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

@interface F4WeChatHandler ()
{
    ShareResult _shareResult;
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

- (BOOL)handleMessage:(F4ShareMessage *)message result:(ShareResult)result
{
    _shareResult = result;

    [self shareToWeChatSession:message result:result];

    return YES;
}

- (BOOL)registerPlatformWithAppID:(NSString *)appID redirectURI:(NSString *)redirectURI
{
    return [WXApi registerApp:appID];
}

- (void)shareToWeChatSession:(F4ShareMessage *)msg result:(ShareResult)result
{
    NSLog(@"weChat");
    [super shareToWeiXinPlatformWithScene:WeChatSceneSession message:msg result:result];
}
@end
