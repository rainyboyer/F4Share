//
//  SinaVC.m
//  F4Share
//
//  Created by Apple on 7/21/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "SinaVC.h"
#import "F4HandleEngine.h"
#import "F4ShareMessage.h"
@interface SinaVC ()

@end

@implementation SinaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *share = @[@"新浪微博分享", @"新浪微博登录"];
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
        message.shareType = ShareNews;
//        message.title = @"分享";
//        message.imageUrl = @"http://42.120.16.240/beeto/addons/theme/beeto/_static/beeto/images/home/banner_5.jpg";
        
        void (^shareResult)(NSInteger,NSString *) = ^(NSInteger stateCode , NSString *stateString)
        {
            NSLog(@"ShareResult: %zd \n stateString = %@", stateCode,stateString);
        };
        [[F4HandleEngine sharedInstance] shareTo:SharePlatformWeibo message:message result:shareResult];
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
