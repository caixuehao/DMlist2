//
//  ESBmob.m
//  DMlist
//
//  Created by 云之彼端 on 15/10/14.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "ESBmob.h"


static ESBmob *bmob;

@implementation ESBmob


+(void)load; {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *appKey = @"e2938113697d0d2495270daaa232058e";//申请的Application ID
        [Bmob registerWithAppKey:appKey];
    });
}

+(ESBmob *)defaultBmob; {
    if (bmob == NULL) {
        bmob = [[ESBmob alloc] init];
    }
    return bmob;
}


-(void)loginWithUsername:(NSString *)username atPassword:(NSString *)password Completed:(void (^)(NSDictionary *, NSError *))completed; {
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"User"];
    [bquery whereKey:@"username" equalTo:username];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSError *_error;
        NSDictionary *result;
        if (array.count >= 1) {
            BmobObject *object = array[0];
            result = [object valueForKey:@"_bmobDataDic"];
            NSLog(@"%@", result);
            
            if (![password isEqualToString:[result valueForKey:@"password"]]) {
                result = nil;
                _error = [[NSError alloc] initWithDomain:@"密码错误" code:-1 userInfo:nil];
            }
        }
        else {
            _error = [[NSError alloc] initWithDomain:@"用户名不存在" code:-2 userInfo:nil];
        }
        completed(result, _error);
    }];
}

@end
