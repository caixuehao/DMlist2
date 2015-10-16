//
//  UserInfo.m
//  DMlist
//
//  Created by duole on 15/10/13.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "UserInfo.h"
#import <BmobSDK/Bmob.h>

NSMutableArray* Users_ARR;
NSMutableDictionary* Users_DIC;
UserInfo* userInfo;

@implementation UserInfo
+(UserInfo*)share{
    if (userInfo == nil) {
        userInfo = [[UserInfo alloc] init];
        
        userInfo.username = @"";
        userInfo.time = nil;
        userInfo.loginOut = YES;

    }
    return userInfo;
}
+(BOOL)setLastTime:(NSDate *)date{
    [UserInfo share].time = date;
    [Users_ARR[0] setValue:date forKey:@"上一次更新时间"];
    [UserInfo writeUsersDIC];
    return YES;
}



+(NSMutableArray*)Users{
    if (Users_DIC == nil) {
        [self readUsersDIC];
    }
    //将默认账号放到第一个
    if(Users_ARR.count>1)//两个以上才排序
    {
        NSString* str = [Users_DIC valueForKey:@"默认账号"];
        if(str.length > 0){//默认账号为空不排序
            for (int i = 0;  i < Users_ARR.count; i++) {
                NSString* username = [Users_ARR[i] valueForKey:@"用户名"];
                if ([str isEqualToString:username]) {
                    //如果想等
                    NSMutableDictionary* dic = Users_ARR[i];
                    [Users_ARR removeObject:dic];
                    [Users_ARR insertObject:dic atIndex:0];
                }
            }
        }
    }
    return Users_ARR;
}
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
//是否自动登录
+(BOOL)autologin{
    if (Users_DIC == nil) {
        [self readUsersDIC];
    }

    if(Users_ARR.count == 0)return NO;
    
    NSString* str = [Users_DIC valueForKey:@"默认账号"];
    if(str.length == 0){//默认账号为空
        return NO;
    }
    return YES;
}
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
+(void)LoginUsername:(NSString *)username Password:(NSString *)password Success:(void (^)())sucess Fail:(void (^)(int i))fail{
    //先判断账号是否正确
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"User"];
    //查询
    [bquery whereKey:@"username" containsAll:@[username]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        
        if (array.count == 0) {
        //登录失败
             [Users_DIC setValue:@"" forKey:@"默认账号"];
            fail(0);return;//没有该账号
        }
        BmobObject* obj = array[0];
        if ([password isEqualToString:[obj objectForKey:@"password"]] == NO) {
            //登录失败
             [Users_DIC setValue:@"" forKey:@"默认账号"];
            fail(1);return;//密码错误
        }
//        if ([[obj objectForKey:@"loginMode"] intValue] == 1) {
//            //登录失败（暂不考虑）
//            fail(2);return;//有人在线了
//        }
        
        //登录成功
        [Users_DIC setValue:username forKey:@"默认账号"];
        [UserInfo share].time = [obj createdAt];
        //把以前的账号删除
        for (int i = 0;  i < Users_ARR.count; i++) {
            NSString* str = [Users_ARR[i] valueForKey:@"用户名"];
            if ([str isEqualToString:username]) {
                //如果相等
                NSMutableDictionary* dic = Users_ARR[i];
//                if ([Users_ARR[i] valueForKey:@"上一次更新时间"] == nil) {
//                     [Users_ARR[i] setValue:[obj createdAt] forKey:@"上一次更新时间"];
//                }
                [UserInfo share].time = [Users_ARR[i] valueForKey:@"上一次更新时间"];
                [Users_ARR removeObject:dic];
            }
        }
        //把新的账号信息加上
        NSDictionary* dic = @{@"用户名":username,
                              @"密码":password,
                              @"昵称":[obj objectForKey:@"nickname"],
                              @"用户类型":[obj objectForKey:@"userType"],
                              @"上一次更新时间":[UserInfo share].time
                              };
        [Users_ARR insertObject:[[NSMutableDictionary alloc] initWithDictionary:dic] atIndex:0];
        //本地化
        [UserInfo writeUsersDIC];
        //同步数据
        [UserInfo share].loginOut = NO;
        [UserInfo share].username = username;
        
        sucess();
    }];
    
   
}
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
+(void)RemoveUser:(NSString *)username{
    for (int i = 0;  i < Users_ARR.count; i++) {
        NSString* username2 = [Users_ARR[i] valueForKey:@"用户名"];
        if ([username isEqualToString:username2]) {
            //如果想等
            NSMutableDictionary* dic = Users_ARR[i];
            [Users_ARR removeObject:dic];
            [UserInfo writeUsersDIC];
        }
    }
}
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
+(void)readUsersDIC{
    //读
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *plistPath=[plistPath1 stringByAppendingPathComponent:@"用户信息.plist"];
    
    Users_DIC = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //如果本地没有plist文件
    if (Users_DIC == nil) {
        //自己新建一个
        NSMutableArray* arr = [[NSMutableArray alloc]init];
        NSDictionary* dic =  @{@"默认账号":@"",@"账号数组":arr};
        Users_DIC = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
    Users_ARR = [Users_DIC valueForKey:@"账号数组"];
    //  NSLog(@"%@",DIC);
}
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
//本地化
+(void)writeUsersDIC{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"用户信息.plist"];
    
    [Users_DIC writeToFile:filename atomically:YES];
}
@end
