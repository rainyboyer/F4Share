//
//  FA_BaseActionSheet.h
//  F4App
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F4ShareMessage.h"
@interface FA_BaseActionSheet : UIView
@property (nonatomic, strong) F4ShareMessage *message;

- (instancetype)initWithTitles:(NSArray *)titles;

/*调用例子
 F4ShareMessage *message = [[F4ShareMessage alloc]init];
 message.url = @"http://www.baidu.com";
 message.title = @"分享新闻";
 message.imageUrl = @"http://42.120.16.240/beeto/addons/theme/beeto/_static/beeto/images/home/banner_5.jpg";
 message.shareType = ShareText;
 message.desc = @"unbelievable";
 message.mediaDataUrl = @"http://www.baidu.com";
 
 FA_BaseActionSheet *actionSheet = [[FA_BaseActionSheet alloc] initWithTitles: @[[NSNumber numberWithInt:SharePlatformWeChat],
 [NSNumber numberWithInt:SharePlatformWeibo],
 [NSNumber numberWithInt:SharePlatformQQ],
 [NSNumber numberWithInt:SharePlatformTimeline]]];
 actionSheet.message = message;
 [self.view addSubview:actionSheet];
 */
@end
