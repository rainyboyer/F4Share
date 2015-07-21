//
//  F4ShareEngine.h
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "F4HandleProtocol.h"
#import "F4ShareMessage.h"
#import "Singleton.h"

@interface F4HandleEngine : NSObject
singleton_interface(F4HandleEngine);

// 注册平台
- (void)register:(id <F4HandleProtocol>)platform;

// 处理分享消息
- (BOOL)shareTo:(SharePlatform)platform message:(F4ShareMessage *)message result:(ShareResult)result;

// 第三方登录
- (BOOL)loginWith:(SharePlatform)platform result:(LoginResult)result;

// 处理回调
- (BOOL)handleWith:(SharePlatform)platform url:(NSURL *)url;

// 设置第三方平台
- (BOOL)registerWith:(SharePlatform)platform appID:(NSString *)appID redirectURI:(NSString *)URI;

+ (BOOL)handleOpenURL:(NSURL *)url;

@end

