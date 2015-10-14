//
//  GCD.h
//  DMlist
//
//  Created by 云之彼端 on 15/10/14.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCD : NSObject

+(void)AfterDelayWithMainQueue:(UInt64)msec block:(dispatch_block_t)block;

@end
