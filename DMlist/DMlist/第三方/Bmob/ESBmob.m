//
//  ESBmob.m
//  DMlist
//
//  Created by 云之彼端 on 15/10/14.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "ESBmob.h"

@implementation ESBmob


+(void)load; {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *appKey = @"e2938113697d0d2495270daaa232058e";//申请的Application ID
        [Bmob registerWithAppKey:appKey];
    });
}


@end
