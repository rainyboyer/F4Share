//
//  ViewController.m
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"
#import "FA_BaseActionSheet.h"
#import "F4ShareMessage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setFrame:CGRectMake(100, 100, 200, 100)];
	[btn setTitle:@"分享" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
    
}

- (void)buttonPressed:(UIButton *)btn
{
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
}

@end
