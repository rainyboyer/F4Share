//
//  F4ShareEngine.m
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "F4HandleEngine.h"
#import "F4QQHandler.h"

@interface F4HandleEngine()
@property (nonatomic, strong) NSMutableDictionary *mapping;
@end
@implementation F4HandleEngine

singleton_implementation(F4HandleEngine);

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _mapping = [[NSMutableDictionary alloc]init];
    }
    return self;
}

#pragma mark - Public Methods
- (BOOL)shareTo:(SharePlatform)platform message:(F4ShareMessage *)message result:(ShareResult)result
{
    NSNumber *key = [NSNumber numberWithInt:platform];
    id <F4HandleProtocol> handler = _mapping[key];
    if (handler == nil)
    {
        return NO;
    }
    
    return [handler handleMessage:message result:result];
}

- (BOOL)loginWith:(SharePlatform)platform result:(LoginResult)result
{
    NSNumber *key = [NSNumber numberWithInt:platform];
    id <F4HandleProtocol> handler = _mapping[key];
    if (handler == nil)
    {
        return NO;
    }
    
    return [handler userLoginResult:result];
}

- (BOOL)handleWith:(SharePlatform)platform url:(NSURL *)url
{
    NSNumber *key = [NSNumber numberWithInt:platform];
    id <F4HandleProtocol> handler = _mapping[key];
    if (handler == nil)
    {
        return NO;
    }
    
    return [handler handleUrl:url];
}

- (void)register:(id<F4HandleProtocol>)platform
{
    NSNumber *key = [self generateKeyWithPlatform:platform];
    _mapping[key] = platform;
    NSLog(@"platform: %@", platform.supportedSharePlatform);
}

- (BOOL)registerWith:(SharePlatform)platform appID:(NSString *)appID redirectURI:(NSString *)redirectURI
{
    NSNumber *key = [NSNumber numberWithInt:platform];
    id <F4HandleProtocol> handler = _mapping[key];
    if (handler == nil)
    {
        return NO;
    }
    
    return [handler registerPlatformWithAppID:appID redirectURI:redirectURI];
}

#pragma mark - Private Methods
- (NSNumber *)generateKeyWithPlatform:(id <F4HandleProtocol>)platform
{
    return platform.supportedSharePlatform;
}

+ (BOOL)handleOpenURL:(NSURL *)url
{
   return   [[F4HandleEngine sharedInstance] handleWith:SharePlatformWeibo url:url] &&
            [[F4HandleEngine sharedInstance] handleWith:SharePlatformWeChat url:url] &&
            [[F4HandleEngine sharedInstance] handleWith:SharePlatformQQ url:url];
}
@end
