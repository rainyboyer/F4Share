//
//  F4TimeLineHandler.m
//  F4Share
//
//  Created by Apple on 7/21/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "F4TimeLineHandler.h"
#import "F4HandleEngine.h"
#import "WXApi.h"

@interface F4TimeLineHandler()
{
    ShareResult _shareResult;
}

@end

@implementation F4TimeLineHandler

- (void)load
{
    [[F4HandleEngine sharedInstance] register:(id <F4HandleProtocol>)self];
}

- (NSNumber *)supportedSharePlatform
{
    return [NSNumber numberWithInteger:SharePlatformTimeline];
}

- (BOOL)registerPlatformWithAppID:(NSString *)appID redirectURI:(NSString *)redirectURI
{
    return [WXApi registerApp:appID];
}

- (BOOL)handleMessage:(F4ShareMessage *)message result:(ShareResult)result
{
    _shareResult = result;
    
    [self shareToWeChatTimeline:message result:result];
    
    return YES;
}

- (void)shareToWeChatTimeline:(F4ShareMessage *)msg result:(ShareResult)result
{
    NSLog(@"TimeLine");
    [super shareToWeiXinPlatformWithScene:WeChatSceneTimeline message:msg result:result];
}
@end
