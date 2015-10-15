//
//  ESBmob.h
//  DMlist
//
//  Created by 云之彼端 on 15/10/14.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  <#Description#>
 */
@interface ESBmob : NSObject

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
+(ESBmob *)defaultBmob;

/**
 *  登录
 *
 *  @param username  用户名
 *  @param password  密码
 *  @param completed 请求完成回调   返回用户信息字典、错误信息
 */
-(void)loginWithUsername:(NSString *)username atPassword:(NSString *)password Completed:(void (^)(NSDictionary *dict, NSError *error))completed;

@end
