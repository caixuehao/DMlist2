//
//  DMlist.m
//  DMlist
//
//  Created by duole on 15/10/14.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "DMlist.h"
#import <BmobSDK/Bmob.h>
#import "UserInfo.h"
#import "sqlite3.h"

NSMutableArray *ARR;
sqlite3* db;

@implementation DMlist
+(void)GetFZList:(void (^)(NSMutableArray *))sucess{
    if (ARR == nil) {
        //先从本地读（顺便把数据库创建一下）
        [DMlist ReadDB];
        //同步网络数据
        if ([UserInfo share].loginOut == NO) {
            [DMlist updata:sucess];
            return;
        }
        
    }

        [DMlist ReadData];
        sucess(ARR);
}
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
//正常删除
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
+(void)removeF:(NSString *)ID Success:(void (^)())sucess Fail:(void (^)(NSInteger))fail{
    if([UserInfo share].loginOut){
        NSLog(@"离线模式不能删除");
        if(fail)fail(0);//离线模式不能添加
        return;
    }
    if (db == nil || ARR == nil) {
        //删除失败
        NSLog(@"%@ 删除失败（数据还没初始化好）",ID);
        if(fail)fail(1);//数据还没初始化好
        return;
    }
    BmobObject *obj = [BmobObject objectWithoutDatatWithClassName:[UserInfo share].username objectId:ID];
    //删除
    [obj deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //删除成功后的动作
            NSLog(@"%@,删除成功",ID);
            //刷新数据（可优化）
            [DMlist ReadData];
            [DMlist removeF:obj];
            //刷新更新时间[两个人登一个号容易导致数据不同步]
            [UserInfo setLastTime:[NSDate date]];
            
            if (sucess!=nil)sucess();
        } else if (error){
            NSLog(@"%@ 删除失败（未知错误）",ID);
            if(fail!=nil)fail(-1);//-1 未知错误
        } else {
            NSLog(@"%@ 添加失败（未知错误）",ID);
            if(fail!=nil)fail(-1);//-1 未知错误
        }
    }];
/*    BmobQuery   *bquery = [BmobQuery queryWithClassName:[UserInfo share].username];
    [bquery whereKey:@"name" containedIn:@[name]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        //查找该元素的id
        if (array.count == 0) {
            if(fail!=nil)fail(2);//没这个数据
            return;
        }
        BmobObject *obj = array[0];
        //删除
        [obj deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //删除成功后的动作
                NSLog(@"%@,删除成功",name);
                //刷新数据（可优化）
                [DMlist ReadData];
                [DMlist removeF:obj];
                if (sucess!=nil)sucess();
            } else if (error){
                NSLog(@"%@ 删除失败（未知错误）",name);
                if(fail!=nil)fail(-1);//-1 未知错误
            } else {
                NSLog(@"%@ 添加失败（未知错误）",name);
                if(fail!=nil)fail(-1);//-1 未知错误
            }
        }];
    }];*/
}
+(void)removeFZ:(NSString *)ID Success:(void (^)())sucess Fail:(void (^)(NSInteger))fail{
    //先看看分组里面有无元素
    for (int i = 0;  i < ARR.count; i++) {
        if ([ID isEqualToString:[ARR[i] valueForKey:@"ID"]]) {
            NSLog(@"%@删除失败（该分组里还有元素）",ID);
            if(fail)fail(-1);//删除失败，该分组里还有元素
            return;
        }
    }
    //然后走流程
    [DMlist removeF:ID Success:sucess Fail:fail];
}
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
//正常添加
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
+(void)addF_name:(NSString *)name remark:(NSString *)remark type:(NSInteger)type titleImageUrl:(NSString *)titleImageUrl FZ:(NSInteger)fz Success:(void (^)())sucess Fail:(void (^)(NSInteger))fail{
    if([UserInfo share].loginOut){
        NSLog(@"离线模式不能添加");
        if(fail!=nil)fail(0);//离线模式不能添加
        return;
    }
    
    if (db == nil || ARR == nil) {
        //添加失败
        NSLog(@"%@ 添加失败（数据还没初始化好）",name);
        if(fail!=nil)fail(1);//数据还没初始化好
        return;
    }

    BmobObject *F = [BmobObject objectWithClassName:[UserInfo share].username];
    [F setObject:name forKey:@"name"];
    [F setObject:remark forKey:@"remark"];
    [F setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [F setObject:titleImageUrl forKey:@"titleImageUrl"];
    [F setObject:[NSNumber numberWithInteger:fz] forKey:@"FZ"];
    [F saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
        if (isSuccessful) {
            //添加成功后的动作
            NSLog(@"%@,服务端添加成功",name);
            [DMlist addF:F];//添加到数据库
            //刷新数据（可优化）
            [DMlist ReadData];
            //刷新更新时间[两个人登一个号容易导致数据不同步]
            [UserInfo setLastTime:[NSDate date]];
            if (sucess!=nil){
                sucess();
            }
            
        } else if (error){
            //发生错误后的动作
             NSLog(@"%@ 添加失败（服务器中有重复）",name);
            if(fail!=nil)fail(error.code);//401 有重复
        } else {
            NSLog(@"%@ 添加失败（未知错误）",name);
            if(fail!=nil)fail(-1);//-1 未知错误
        }
    }];

}
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
//修改
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
+(void)setF_oldname:(NSString *)ID Name:(NSString *)name remark:(NSString *)remark type:(NSInteger)type titleImageUrl:(NSString *)titleImageUrl Success:(void (^)())sucess Fail:(void (^)(NSInteger))fail{
    
    if([UserInfo share].loginOut){
        NSLog(@"离线模式不能添加");
        if(fail!=nil)fail(0);//离线模式不能添加
        return;
    }
    
    if (db == nil || ARR == nil) {
        //修改失败
        NSLog(@"%@ 添加失败（数据还没初始化好）",ID);
        if(fail!=nil)fail(1);//数据还没初始化好
        return;
    }
    
    BmobObject *obj = [BmobObject objectWithoutDatatWithClassName:[UserInfo share].username objectId:ID];
    
     if(name)[obj setObject:name forKey:@"name"];
     if(remark)[obj setObject:remark forKey:@"remark"];
     if(type)[obj setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
     if(titleImageUrl)[obj setObject:titleImageUrl forKey:@"titleImageUrl"];
    
    [obj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //修改成功后的动作
            [DMlist setF:obj];
            //刷新数据（可优化）
            [DMlist ReadData];
            //刷新更新时间[两个人登一个号容易导致数据不同步]
            [UserInfo setLastTime:[NSDate date]];
            if (sucess!=nil){
                sucess();
            }
        } else if (error){
            NSLog(@"%@ 修改失败",ID);
            if(fail!=nil)fail(error.code);
        } else {
             NSLog(@"%@ 修改失败",ID);
            if(fail!=nil)fail(2);
        }
    }];


}
//777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
//777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
////是否可以执行操作
//+(BOOL)YesOrNoFail:(void (^)(NSInteger))fail{
//    if([UserInfo share].loginOut){
//        NSLog(@"离线模式不能操作");
//        if(fail!=nil)fail(0);//离线模式不能添加
//        return NO;
//    }
//    
//    if (db == nil || ARR == nil) {
//        //修改失败
//        NSLog(@"操作失败 数据还没初始化好）");
//        if(fail!=nil)fail(1);//数据还没初始化好
//        return NO;
//    }
//    
//    return YES;
//}

// 从服务器添加东西到数据库
+(void)addF:(BmobObject*)obj{
    NSString *sql = [[NSString alloc]initWithFormat:@"insert into H values('%@','%@','%@','%@','%@','%@')",
                    [obj objectForKey:@"name"],
                    [obj objectForKey:@"remark"],
                    [obj objectForKey:@"type"],
                    [obj objectForKey:@"titleImageUrl"],
                    [obj objectForKey:@"FZ"],
                    [obj objectId]
                    ];
    //添加
    sqlite3_stmt *statement;
//    int error =
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
//    NSLog(@"%d",error);
    if (sqlite3_step(statement) == SQLITE_DONE){
        NSLog(@"%@,数据库添加成功",[obj objectForKey:@"name"]);
    }else{
        NSLog(@"%@,添加失败(数据库有重复)",[obj objectForKey:@"name"]);
    }
}
// 删除数据库数据
+(void)removeF:(BmobObject*)obj{
    NSString* name = [obj objectId];
    NSString *sql = [[NSString alloc]initWithFormat:@"delete from H where IDTEST ='%@'",name];
    
    sqlite3_stmt *statement;
//    int error =
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
//    NSLog(@"%d",error);
    if (sqlite3_step(statement) == SQLITE_DONE){
        NSLog(@"%@,数据库删除成功",name);
    }else{
        NSLog(@"%@,数据删除失败",name);
    }

}
// 修改数据库数据
+(void)setF:(BmobObject*)obj{
    NSString* ID = [obj objectId];
    
    NSString* str = [[NSString alloc] initWithFormat:@"type = '%@'",[obj objectForKey:@"type"]];
    NSString* name = [obj objectForKey:@"name"];
    NSString* remark = [obj objectForKey:@"remark"];
    NSString* titleImageUrl = [obj objectForKey:@"titleImageUrl"];
    
     if(name) str = [str stringByAppendingString:[[NSString alloc] initWithFormat:@" , name = '%@'",name]];
    if (remark) str = [str stringByAppendingString:[[NSString alloc] initWithFormat:@" , remark = '%@'",remark]];
     if (titleImageUrl) str = [str stringByAppendingString:[[NSString alloc] initWithFormat:@" , titleImageUrl = '%@'",titleImageUrl]];
    
    
    NSString *sql = [[NSString alloc]initWithFormat:@"UPDATE H SET %@ WHERE IDTEST ='%@'",str,ID];
    
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
    int error = sqlite3_step(statement);
    
//    NSLog(@"%d",error);
    if (error == SQLITE_DONE){
        NSLog(@"%@,数据库修改成功",ID);
    }else{
        NSLog(@"%@,数据修改失败",ID);
    }

}
//777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
//777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777

//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
//同步数据
+(void)updata:(void (^)(NSMutableArray *))sucess{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:[UserInfo share].username];
    //查询
    if ([UserInfo share].time!=nil) {
        //同上次同步之后有更新的
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentDateStr = [dateFormatter stringFromDate:[UserInfo share].time];
        NSDictionary *condiction1 = @{@"updatedAt":@{@"$gte":@{@"__type": @"Date", @"iso": currentDateStr}}};
        [bquery addTheConstraintByAndOperationWithArray:@[condiction1]];
    }
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            NSDate *  date= [[obj createdAt] laterDate:[UserInfo share].time];
            if([date isEqualToDate:[obj createdAt]]){
                NSLog(@"添加：%@",[obj objectForKey:@"name"]);
                [DMlist addF:obj];
            }else{
                NSLog(@"更新：%@",[obj objectForKey:@"name"]);
                [DMlist setF:obj];
            }
            
        }
        //更新同步时间
        NSDate* date = [NSDate date];
        NSLog(@"更新时间:%@",date);
        [UserInfo setLastTime:date];
        //读数据库
        [DMlist ReadData];
        sucess(ARR);
    }];

}
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
//读本地数据库(防止没创建)
+(void)ReadDB{
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *FilePath = [paths objectAtIndex:0];
    FilePath=[FilePath stringByAppendingPathComponent:[[UserInfo share].username stringByAppendingString:@".db"]];
    NSLog(@"%@",FilePath);
    //判断文件是否存在
    NSFileManager *filemgr = [NSFileManager defaultManager];
    BOOL bl = [filemgr fileExistsAtPath: FilePath];
    
      
    //读取本地文件
    //判断数据库是否打开成功
    if (sqlite3_open([FilePath UTF8String], &(db)) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"数据库打开失败。");
    }
    //如果不存在创建表
    if (bl == NO) {
        NSLog(@"%@文件不存在",FilePath);
        //创建表
        //名字 备注 标识符 封面 FZ
        NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS H (name TEXT,remark TEXT,type INTEGER, titleImageUrl TEXT,FZ INTEGER,IDTEST TEXT PRIMARY KEY)";
        sqlite3_stmt *statement;
        int error =
        sqlite3_prepare_v2(db, [sqlCreateTable UTF8String], -1, &statement, nil);
        NSLog(@"%d",error);
        if (sqlite3_step(statement) != SQLITE_DONE){
            NSLog(@"表创建失败");
        }
    }
}
//读数据
+(void)ReadData{
    
     ARR = [[NSMutableArray alloc] init];
    
    //先查数组查询
    NSString *sql = @"SELECT * FROM H WHERE FZ = '1'";
    sqlite3_stmt *statement;
    int error =sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
    
    if (error == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *name = (char *)sqlite3_column_text(statement, 0);
            NSString *nameStr = [[NSString alloc] initWithUTF8String:name];
            
            char *remark = (char *)sqlite3_column_text(statement, 1);
            NSString *remarkStr = [[NSString alloc] initWithUTF8String:remark];
            
            char *type = (char *)sqlite3_column_text(statement, 2);
            NSString *typeStr = [[NSString alloc] initWithUTF8String:type];
            
            char *titleImageUrl = (char *)sqlite3_column_text(statement, 3);
            NSString *titleImageUrlStr = [[NSString alloc] initWithUTF8String:titleImageUrl];
            
            char *ID = (char *)sqlite3_column_text(statement, 5);
            NSString *IDStr = [[NSString alloc] initWithUTF8String:ID];
            
            NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithDictionary:
                                        @{
                                          @"分组名":nameStr,
                                          @"备注:":remarkStr,
                                          @"标识符":typeStr,
                                          @"封面网址":titleImageUrlStr,
                                          @"ID":IDStr
                                          }];
            [ARR addObject:dic];
        }
        sqlite3_finalize(statement);
    }else{
        NSLog(@"分组查询失败");
    }
    //再查元素
    for (int i = 0; i < ARR.count; i++) {
        NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM H WHERE type = '%@' and FZ = '0'",[ARR[i] valueForKey:@"标识符"]];
        
        sqlite3_stmt *statement;
        int error =sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        if (error == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char *name = (char *)sqlite3_column_text(statement, 0);
                NSString *nameStr = [[NSString alloc] initWithUTF8String:name];
                
                char *remark = (char *)sqlite3_column_text(statement, 1);
                NSString *remarkStr = [[NSString alloc] initWithUTF8String:remark];
                
                char *type = (char *)sqlite3_column_text(statement, 2);
                NSString *typeStr = [[NSString alloc] initWithUTF8String:type];
                
                char *titleImageUrl = (char *)sqlite3_column_text(statement, 3);
                NSString *titleImageUrlStr = [[NSString alloc] initWithUTF8String:titleImageUrl];
                
                char *ID = (char *)sqlite3_column_text(statement, 5);
                NSString *IDStr = [[NSString alloc] initWithUTF8String:ID];
                
                NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithDictionary:
                                            @{
                                              @"名字":nameStr,
                                              @"备注:":remarkStr,
                                              @"标识符":@([typeStr intValue]),
                                              @"封面网址":titleImageUrlStr,
                                              @"ID":IDStr
                                              }];
                [arr addObject:dic];
            }
            [ARR[i] setValue:arr forKey:@"元素数组"];
            sqlite3_finalize(statement);
        }else{
            NSLog(@"%@分组查询失败",[ARR[i] valueForKey:@"分组名"]);
        }
    }
}

@end
