//
//  MainImage.h
//  DMlist
//
//  Created by duole on 15/10/12.
//  Copyright © 2015年 cai. All rights reserved.
//
//负责同步服务器上的图片
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MainImage : NSObject
/**
 *设置UIiamgeView type(图片类型如@“启动图”)
 */
+(void)setImageView:(UIImageView*)iv IamgeType:(NSString*)type;
@end
