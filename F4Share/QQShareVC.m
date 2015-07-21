//
//  QQShareVC.m
//  F4Share
//
//  Created by Apple on 7/16/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "QQShareVC.h"
#import "F4QQHandler.h"
#import "F4WeiboHandler.h"
#import "F4HandleEngine.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface QQShareVC ()

@end

@implementation QQShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSArray *share = @[@"QQ分享", @"QQ登录"];
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
        message.title = @"分享新闻";
        message.imageUrl = @"http://42.120.16.240/beeto/addons/theme/beeto/_static/beeto/images/home/banner_5.jpg";
        message.shareType = ShareVideo;
        message.desc = @"unbelievable";
        message.mediaDataUrl = @"http://www.baidu.com";
        
        void (^shareResult)(NSInteger,NSString *) = ^(NSInteger stateCode , NSString *stateString)
        {
            NSLog(@"ShareResult: %zd \n stateString = %@", stateCode,stateString);
        };
        [[F4HandleEngine sharedInstance] shareTo:SharePlatformQQ message:message result:shareResult];
    }
    else if (btn.tag == 1)
    {
        void (^loginReuslt)(F4ShareUserInfo *, NSInteger, NSString *) = ^(F4ShareUserInfo *userInfo, NSInteger stateCode,NSString *stateString)
        {
            NSLog(@"LoginResult: stateCode = %zd \n, userInfo = %@ \n stateString = %@", stateCode, userInfo,stateString);
        };
        
        [[F4HandleEngine sharedInstance] loginWith:SharePlatformWeibo result:loginReuslt];
    }
}


@end
