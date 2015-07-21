//
//  AppDelegate.m
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "F4HandleEngine.h"
#import "F4QQHandler.h"
#import "F4WeiboHandler.h"
#import "F4TimeLineHandler.h"
#import "F4WeChatHandler.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    F4QQHandler *qqHandler = [[F4QQHandler alloc]init];
    [qqHandler load];
    
    F4WeiboHandler *weiboHandler = [[F4WeiboHandler alloc] init];
    [weiboHandler load];
    
    F4WeChatHandler *weChatHandler = [[F4WeChatHandler alloc]init];
    [weChatHandler load];
    
    F4TimeLineHandler *timeLineHandler = [[F4TimeLineHandler alloc]init];
    [timeLineHandler load];

    [[F4HandleEngine sharedInstance] registerWith:SharePlatformQQ appID:@"1104720510" redirectURI:@"http://www.qq.com"];
    [[F4HandleEngine sharedInstance] registerWith:SharePlatformWeibo appID:@"1425226178" redirectURI:@"http://www.beetto.com"];
    [[F4HandleEngine sharedInstance] registerWith:SharePlatformWeChat appID:@"wx78a4899f5331a20f" redirectURI:@"http://www.baidu.com"];
        [[F4HandleEngine sharedInstance] registerWith:SharePlatformTimeline appID:@"wx78a4899f5331a20f" redirectURI:@"http://www.baidu.com"];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [F4HandleEngine handleOpenURL:url];
}

@end
