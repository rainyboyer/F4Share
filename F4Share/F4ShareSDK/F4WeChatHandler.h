//
//  F4WeChatHandler.h
//  shareDemo
//
//  Created by Ryan on 15/7/17.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "F4HandleProtocol.h"

typedef enum {
    WeChatSceneSession  = 0,
    WeChatSceneTimeline = 1,
    WeChatSceneFavorite = 2,
}WeChatScene;

@interface F4WeChatHandler : NSObject <F4HandleProtocol>

- (void)load;

@end
