//
//  GCD.m
//  DMlist
//
//  Created by 云之彼端 on 15/10/14.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "GCD.h"

@implementation GCD

+(void)AfterDelayWithMainQueue:(UInt64)msec block:(dispatch_block_t)block; {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_MSEC * msec), dispatch_get_main_queue(), block);
}


@end
