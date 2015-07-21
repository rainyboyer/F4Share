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
    LoginResult _loginResult;
    WeChatScene _scene;
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

- (BOOL)handleMessage:(F4ShareMessage *)message shareResult:(ShareResult)result
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
    _scene = WeChatSceneSession;
    _shareResult = result;

    if (!msg.shareType)
    {
        //不指定类型
        if ([msg isEmpty:@[@"imageUrl",@"url"] AndNotEmpty:@[@"title"]])
        {
            //文本
            [self sendTextContentWithMessage:msg result:result];

        }else if([msg isEmpty:@[@"url"] AndNotEmpty:@[@"imageUrl"]])
        {
            //图片
            [self sendImageContentWithMessage:msg];

        }else if([msg isEmpty:nil AndNotEmpty:@[@"url",@"title",@"imageUrl"]])
        {
            //混合。
            [self sendNewsContentWithMessage:msg];

        }else if ([msg isEmpty:@[@"title",@"imageUrl"] AndNotEmpty:@[@"url"]])
        {
            //只分享Url
            [self sendUrlContentWithMessage:msg];

        }
    }
    else if(msg.shareType==ShareMusic)
    {
        //music
        [self sendMusicContentWithMessage:msg];

    }
    else if(msg.shareType==ShareVideo)
    {
        //video
        [self sendVideoContentWithMessage:msg];
    }
    else if(msg.shareType==ShareApp)
    {
        //app
        [self sendAppContentWithMessage:msg];

    }else if (msg.shareType == ShareGif)
    {
        //Gif
        [self sendGifContentWithMessage:msg];

    }else if (msg.shareType == ShareNonGif)
    {
        //NonGif
        [self sendNonGifContentWithMessage:msg];
    }
}

- (void)shareToWeChatTimeline:(F4ShareMessage *)msg result:(ShareResult)result
{
    _scene = WeChatSceneTimeline;
    _shareResult = result;

    if (!msg.shareType)
    {
        //不指定类型
        if ([msg isEmpty:@[@"imageUrl",@"url"] AndNotEmpty:@[@"title"]]) {
            //文本
            [self sendTextContentWithMessage:msg result:result];

        }else if([msg isEmpty:@[@"url"] AndNotEmpty:@[@"imageUrl"]]){
            //图片
            [self sendImageContentWithMessage:msg];
        }else if([msg isEmpty:nil AndNotEmpty:@[@"url",@"title",@"imageUrl"]]){
            //有链接。
            [self sendNewsContentWithMessage:msg];
        }
    }
    else if(msg.shareType==ShareMusic)
    {
        //music
        [self sendMusicContentWithMessage:msg];

    }
    else if(msg.shareType==ShareVideo)
    {
        //video
        [self sendVideoContentWithMessage:msg];
    }
    else if(msg.shareType==ShareApp)
    {
        //app
        [self sendAppContentWithMessage:msg];

    }else if (msg.shareType == ShareGif)
    {
        [self sendGifContentWithMessage:msg];

    }else if (msg.shareType == ShareNonGif)
    {
        [self sendNonGifContentWithMessage:msg];
    }

}

- (void)shareToWeChatFavorite:(F4ShareMessage *)msg result:(ShareResult)result
{
    _scene = WeChatSceneFavorite;
    _shareResult = result;

    if (!msg.shareType)
    {
        //不指定类型
        if ([msg isEmpty:@[@"imageUrl",@"url"] AndNotEmpty:@[@"title"]])
        {
            //文本
            [self sendTextContentWithMessage:msg result:result];

        }else if([msg isEmpty:@[@"url"] AndNotEmpty:@[@"imageUrl"]])
        {
            //图片
            [self sendImageContentWithMessage:msg];
        }else if([msg isEmpty:nil AndNotEmpty:@[@"url",@"title",@"imageUrl"]])
        {
            //有链接。
            [self sendNewsContentWithMessage:msg];
        }
    }
    else if(msg.shareType==ShareMusic)
    {
        //music
        [self sendMusicContentWithMessage:msg];
    }
    else if(msg.shareType==ShareVideo)
    {
        //video
        [self sendVideoContentWithMessage:msg];
    }
    else if(msg.shareType==ShareApp)
    {
        //app
        [self sendAppContentWithMessage:msg];

    }else if (msg.shareType == ShareGif)
    {
        [self sendGifContentWithMessage:msg];

    }else if (msg.shareType == ShareNonGif)
    {
        [self sendNonGifContentWithMessage:msg];
    }
}

- (void)sendTextContentWithMessage:(F4ShareMessage *)msg result:(ShareResult)result
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = msg.title.length > 0 ? msg.title : @"";

    req.bText = YES;
    req.scene = _scene;

    [WXApi sendReq:req];
}

- (void)sendImageContentWithMessage:(F4ShareMessage *)msg
{
    WXMediaMessage *message = [WXMediaMessage message];
    if (msg.thumbnailUrl)
    {
        [message setThumbData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msg.thumbnailUrl]]];
    }

    WXImageObject *ext = [WXImageObject object];
    ext.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:msg.imageUrl]];

    message.mediaObject = ext;

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];
}

- (void)sendNewsContentWithMessage:(F4ShareMessage *)msg
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = msg.title;
    message.description = msg.desc;
    [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msg.imageUrl]]]];

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = msg.url;

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];
}

- (void)sendMusicContentWithMessage:(F4ShareMessage *)msg
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = msg.title;
    message.description = msg.desc;

    WXMusicObject *ext = [WXMusicObject object];
    ext.musicUrl = @"http://y.qq.com/i/song.html#p=7B22736F6E675F4E616D65223A22E4B880E697A0E68980E69C89222C22736F6E675F5761704C69766555524C223A22687474703A2F2F74736D7573696334382E74632E71712E636F6D2F586B30305156342F4141414130414141414E5430577532394D7A59344D7A63774D4C6735586A4C517747335A50676F47443864704151526643473444442F4E653765776B617A733D2F31303130333334372E6D34613F7569643D3233343734363930373526616D703B63743D3026616D703B636869643D30222C22736F6E675F5769666955524C223A22687474703A2F2F73747265616D31342E71716D757369632E71712E636F6D2F33303130333334372E6D7033222C226E657454797065223A2277696669222C22736F6E675F416C62756D223A22E4B880E697A0E68980E69C89222C22736F6E675F4944223A3130333334372C22736F6E675F54797065223A312C22736F6E675F53696E676572223A22E5B494E581A5222C22736F6E675F576170446F776E4C6F616455524C223A22687474703A2F2F74736D757369633132382E74632E71712E636F6D2F586C464E4D313574414141416A41414141477A4C36445039536A457A525467304E7A38774E446E752B6473483833344843756B5041576B6D48316C4A434E626F4D34394E4E7A754450444A647A7A45304F513D3D2F33303130333334372E6D70333F7569643D3233343734363930373526616D703B63743D3026616D703B636869643D3026616D703B73747265616D5F706F733D35227D";
    ext.musicDataUrl = @"http://stream20.qqmusic.qq.com/32464723.mp3";

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];

}

- (void)sendVideoContentWithMessage:(F4ShareMessage *)msg
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = msg.title;
    message.description = msg.desc;

    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl = @"http://v.youku.com/v_show/id_XNTUxNDY1NDY4.html";

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];

}

#define BUFFER_SIZE 1024 * 100
- (void)sendAppContentWithMessage:(F4ShareMessage *)msg
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = msg.title;
    message.description = msg.desc;

    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = @"<xml>extend info</xml>";
    ext.url = @"http://www.qq.com";

    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
    memset(pBuffer, 0, BUFFER_SIZE);
    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
    free(pBuffer);

    ext.fileData = data;

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];

}

- (void)sendGifContentWithMessage:(F4ShareMessage *)msg
{
    WXMediaMessage *message = [WXMediaMessage message];

    WXEmoticonObject *ext = [WXEmoticonObject object];

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];

}

- (void)sendNonGifContentWithMessage:(F4ShareMessage *)msg
{
    WXMediaMessage *message = [WXMediaMessage message];


    WXEmoticonObject *ext = [WXEmoticonObject object];

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];

}

- (void)sendUrlContentWithMessage:(F4ShareMessage *)msg
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = msg.title.length > 0 ? msg.title : @"";
    message.description = msg.desc.length > 0 ? msg.desc : @"";

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = msg.url.length > 0 ? msg.url : @"";

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];
}

- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *stateString = nil;
        
        switch (resp.errCode)
        {
            case WXSuccess:
                stateString = @"成功";
                break;
            case WXErrCodeCommon:
                stateString = @"成功";
                break;
            case WXErrCodeUserCancel:
                stateString = @"用户取消";
                break;
            case WXErrCodeSentFail:
                stateString = @"发送失败";
                break;
            case WXErrCodeAuthDeny:
                stateString = @"授权否决";
                break;
            case WXErrCodeUnsupport:
                stateString = @"设备不支持";
                break;
            default:
                break;
        }
        
        if (_shareResult)
        {
            _shareResult(resp.errCode,stateString);
        }
        
    }
}



@end
