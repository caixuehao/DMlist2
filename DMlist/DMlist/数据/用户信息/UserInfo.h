//
//  UserInfo.h
//  DMlist
//
//  Created by duole on 15/10/13.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property(nonatomic,strong)NSString* username;//当前登录成功的用户名
@property(nonatomic,assign)BOOL loginOut;//YES离线登录  NO正常登录
@property(nonatomic,strong)NSDate* time;//上一次更新时间
/**
 *返回已经通过验证的用户数组(第一个是默认账号［或者叫上一次成功登录的账号］)
 */
+(NSMutableArray*)Users;
/**
 *删除一个已经记录的账号
 */
+(void)RemoveUser:(NSString*)username;
/**
 *登录 验证账号密码 成功调用 失败调用
 */
+(void)LoginUsername:(NSString*)username Password:(NSString*)password Success:(void(^)())sucess Fail:(void(^)(int i))fail;
/**
 *是否自动登录
 */
+(BOOL)autologin;
/**
 *返回一个单例用来获取其他信息
 */
+(UserInfo*)share;
/**
 *设置最后更新的时间
 */
+(BOOL)setLastTime:(NSDate*)date;
@end
