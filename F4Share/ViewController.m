//
//  ViewController.m
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"
#import "QQShareVC.h"
#import "SinaVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *share = @[@"QQ", @"微博"];
    
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
        QQShareVC *qqShare = [[QQShareVC alloc]init];
        [self presentViewController:qqShare animated:YES completion:^{
        }];
    }
    else if (btn.tag == 1)
    {
        SinaVC *sina = [[SinaVC alloc]init];
        [self presentViewController:sina animated:YES completion:^{
        }];
    }
}

@end
