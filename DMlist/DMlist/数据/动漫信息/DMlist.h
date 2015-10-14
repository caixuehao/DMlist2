//
//  DMlist.h
//  DMlist
//
//  Created by duole on 15/10/14.
//  Copyright © 2015年 cai. All rights reserved.
//
/*
 //分组信息结构
 [
    {
        名字:，
        标识符:，
        备注:，
        动漫封面:，
        封面文件:,
        元素数组指针:
    },
    {
    },
    ........
 ]
 //元素
 [
    {
        名字:，
        标识符:，
        备注:，
        动漫封面:，
        封面文件:
    },
    {
    },
    ......
 ]
 */
#import <Foundation/Foundation.h>

@interface DMlist : NSObject
/**
 *获取动漫分组信息
 */
+(NSMutableArray*)GetFZList;
/**
 *修改分组信息
 */

@end
