//
//  F4WeiXinBaseHandler.h
//  F4Share
//
//  Created by Apple on 7/21/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "F4HandleProtocol.h"

@interface F4WeiXinBaseHandler : NSObject

- (void)shareToWeiXinPlatformWithScene:(WeChatScene)scene message:(F4ShareMessage *)msg result:(ShareResult)result;
@end
