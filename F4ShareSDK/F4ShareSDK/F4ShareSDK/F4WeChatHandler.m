//
//  F4WeChatHandler.m
//  shareDemo
//
//  Created by Ryan on 15/7/17.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "F4WeChatHandler.h"
#import "F4HandleEngine.h"
#import "WXApi.h"
#import "F4ShareHTTPTool.h"

typedef enum
{
    Token,
    UserInfo
}requesCode;

@interface F4WeChatHandler ()
{
    ShareResult _shareResult;
    LoginResult _loginResult;
    NSString *_securityKey;
    NSString *_appID;
    NSString *_token;// 获取用户信息token
    NSString *_openID;
    NSMutableData *_receiveData;
    requesCode _currentRequestCode;
}

@end

@implementation F4WeChatHandler

- (void)load
{
    [[F4HandleEngine sharedInstance] register:(id <F4HandleProtocol>)self];
}

- (NSNumber *)supportedSharePlatform
{
    return [NSNumber numberWithInteger:SharePlatformWeChat];
}

- (NSString *)getPlatformName
{
    return @"微信好友";
}

- (NSString *)getPlatformImageName
{
    return @"img_icon_wechat";
}

- (BOOL)handleMessage:(F4ShareMessage *)message result:(ShareResult)result
{
    _shareResult = result;

    [self shareToWeChatSession:message result:result];

    return YES;
}

- (BOOL)handleWithSourceApplication:(NSString *)application url:(NSURL *)url
{
    if ([application isEqualToString:@"com.tencent.xin"])
    {
        if([url.host isEqualToString:@"oauth"])
        {
            NSLog(@"微信登录");
            NSDictionary *dic = [self getDataDictionaryWithPort:url.query];
            [self resquestTokenFromWechatWithCode:[dic objectForKey:@"code"]];
            [WXApi handleOpenURL:url delegate:self];
        }
        else
        {
            NSLog(@"微信好友反馈");
            [WXApi handleOpenURL:url delegate:self];
        }

        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)registerPlatformWithAppID:(NSString *)appID redirectURI:(NSString *)redirectURI security:(NSString *)security
{
    _appID = appID;
    _securityKey = security;
    return [WXApi registerApp:appID];
}

- (void)shareToWeChatSession:(F4ShareMessage *)msg result:(ShareResult)result
{
    NSLog(@"weChat");
    [super shareToWeiXinPlatformWithScene:WeChatSceneSession message:msg result:result];
}

- (BOOL)userLoginResult:(LoginResult)result
{
    // 需先判断系统是否已安装微信
    _loginResult = result;
    
    SendAuthReq *req = [[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"wechat_sdk_demo_test";
    return [WXApi sendAuthReq:req
               viewController:nil
                     delegate:self];
}

- (void)onResp:(BaseResp *)resp
{
    if (resp.errCode >0)
    {
        _loginResult(nil, resp.errCode, resp.errStr);
    }
}

#pragma mark - Private Methods
//  url.port转换为Dictionary
- (NSDictionary *)getDataDictionaryWithPort:(NSString *)port
{
    NSArray *cacheStrings = [port componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    for (NSString *string in cacheStrings)
    {
        NSArray *strings = [string componentsSeparatedByString:@"="];
        [dic setObject:[strings objectAtIndex:1] forKey:[strings objectAtIndex:0]];
    }
    return dic;
}

//  请求获取token
- (void)resquestTokenFromWechatWithCode:(NSString *)code
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", _appID, _securityKey, code]];
    _currentRequestCode = Token;
    [self requestWithUrl:url];
}
- (void)resquestUserInfoFromWechat
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", _token, _openID]];
    _currentRequestCode = UserInfo;
    [self requestWithUrl:url];
}

//  根据url请求数据
- (void)requestWithUrl:(NSURL *)url
{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

//  字符串转换为字典
- (NSDictionary *)stringToDictionaryWith:(NSString *)string
{
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    return dic;
}

#pragma mark - Request Methods
//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    _receiveData = [NSMutableData data];
    
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveStr = [[NSString alloc]initWithData:_receiveData encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [self stringToDictionaryWith:receiveStr];
    if (_currentRequestCode == Token)
    {
        _token = [dic objectForKey:@"access_token"];
        _openID = [dic objectForKey:@"openid"];
        [self resquestUserInfoFromWechat];
    }
    else if (_currentRequestCode == UserInfo)
    {
        F4ShareUserInfo *userInfo = [F4ShareUserInfo qqUserInfoWithJson:dic];
        _loginResult(userInfo, 0, @"成功");
    }
    else
    {
        NSLog(@"info error");
    }
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}
@end
