//
//  BaiDu.h
//  DMlist
//
//  Created by duole on 15/9/7.
//  Copyright (c) 2015年 duole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaiDu : NSObject
/**
 *  设置封面
 *
 *  @param 封面视图
 *
 *  @param 词条
 *
 *  @return 返回是否成功
 */
+(BOOL)setFenMian:(UIImageView*)imageView CiTiao:(NSString*)ciTiao;

+(void*)getImageArr:(void(^)(NSString* imageArr))Huidiao CiTiao:(NSString*)ciTiao;



@end
