//
//  WeChatVC.m
//  F4Share
//
//  Created by Apple on 7/21/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "WeChatVC.h"
#import "F4ShareMessage.h"
#import "F4HandleEngine.h"
#import "F4WeChatHandler.h"
#import "F4TimeLineHandler.h"
@interface WeChatVC ()

@end

@implementation WeChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *share = @[@"微信好友分享", @"微信朋友圈分享"];
    for (int i = 0; i < share.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(100, 200*i, 200, 100)];
        [btn setTitle:[share objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)buttonPressed:(UIButton *)btn
{
    
    if (btn.tag == 0)
    {
        F4ShareMessage *message = [[F4ShareMessage alloc]init];
        message.url = @"http://www.baidu.com";
//        message.shareType = ShareText;
        //        message.title = @"分享";
        //        message.imageUrl = @"http://42.120.16.240/beeto/addons/theme/beeto/_static/beeto/images/home/banner_5.jpg";
        
        void (^shareResult)(NSInteger,NSString *) = ^(NSInteger stateCode , NSString *stateString)
        {
            NSLog(@"ShareResult: %zd \n stateString = %@", stateCode,stateString);
        };
        [[F4HandleEngine sharedInstance] shareTo:SharePlatformWeChat message:message result:shareResult];
    }
    else if (btn.tag == 1)
    {
        F4ShareMessage *message = [[F4ShareMessage alloc]init];
        message.url = @"http://www.baidu.com";
//        message.shareType = ShareNews;
        //        message.title = @"分享";
        //        message.imageUrl = @"http://42.120.16.240/beeto/addons/theme/beeto/_static/beeto/images/home/banner_5.jpg";
        
        void (^shareResult)(NSInteger,NSString *) = ^(NSInteger stateCode , NSString *stateString)
        {
            NSLog(@"ShareResult: %zd \n stateString = %@", stateCode,stateString);
        };
        
        [[F4HandleEngine sharedInstance] shareTo:SharePlatformTimeline message:message result:shareResult];
    }
}

@end
