//
//  F4ShareNetworkTool.m
//  shareDemo
//
//  Created by Ryan on 15/7/17.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "F4ShareHTTPTool.h"
#import <AFHTTPRequestOperationManager.h>
#import "F4ShareUserInfo.h"

@implementation F4ShareHTTPTool
singleton_implementation(F4ShareHTTPTool)

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success fail:(FailBlock)fail
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            F4ShareUserInfo *userInfo = [F4ShareUserInfo weiBoUserInfoWithJson:responseObject];
            if (success)
            {
                success(userInfo);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (error)
        {
            if (fail)
            {
                fail(error);
            }
        }
    }];
}


@end
