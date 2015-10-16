//
//  BaiDu.m
//  DMlist
//
//  Created by duole on 15/9/7.
//  Copyright (c) 2015年 duole. All rights reserved.
//

#import "BaiDu.h"
#import "AFNetworking.h"
#import "RegexKitLite.h"
#import "DMlist.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"

//static NSMutableArray* ARR;
//static NSMutableDictionary* DIC;
@implementation BaiDu


+(BOOL)setFenMian:(UIImageView *)imageView CiTiao:(NSString *)ciTiao{
    //看看本地有没有
    NSString* hstr = [DMlist getImageCache:ciTiao];
    if (hstr.length!=0) {
        [imageView sd_setImageWithURL:[[NSURL alloc] initWithString:hstr] placeholderImage:[UIImage imageNamed:@"锁链背景图"]];
        return YES;
    }
    
//    NSLog(@"词条：%@",ciTiao);
    NSURL *url = [[NSURL alloc] initFileURLWithPath:ciTiao];
    NSString * requestAddress = [[NSString alloc] initWithFormat:@"http://image.baidu.com/search/index?tn=baiduimage&word=%@",[url relativeString]];
//    NSLog(@"%@",requestAddress);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //默认解析成json  设置解析成nsdata
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:requestAddress
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             
             NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             if (!str){NSLog(@"地址%@没有获取到数据",url); return;}
             
             //***********查找***********
             NSString *regexString = @"\"objURL\":\"(.*?)\"";//10
//              NSString *regexString = @"\"objURL\":\"(.*?)\"";
             NSRegularExpression * regex = [[NSRegularExpression alloc]initWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
             [regex enumerateMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                 if (result) {
                //   *stop = YES;//为空停止查找
                     //查找到的内容
                     NSString* str2 = [str substringWithRange:result.range];
                     str2 = [str2 substringWithRange:NSMakeRange(10, str2.length-11)];
                     //gif先剔除
                     if ([[str2 substringFromIndex:str2.length-3] isEqualToString:@"gif"]) {return;}
                     NSLog(@"imageURL:%@",str2);
                     
                     //设置封面
                     [imageView sd_setImageWithURL:[[NSURL alloc] initWithString:str2] placeholderImage:[UIImage imageNamed:@"锁链背景图"]];
                     *stop = YES;//停止查找
                     //存到缓存数据库
                     [DMlist addImageCache:str2 CiTiao:ciTiao];
//                     [DIC setObject:str2 forKey:ciTiao];
                 }
                 
             } ];

             
             
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
         }];
    return YES;
}



+(void*)getImageArr:(void(^)(NSString* imageArr))Huidiao CiTiao:(NSString*)ciTiao{
//    NSLog(@"词条：%@",ciTiao);
    //判断本地是否已经有封面
//    NSMutableDictionary* Dic =  [[BaiDu GetFanWangZhiDIC] objectForKey:ciTiao];
//    NSString * nowimage = [Dic objectForKey:@"封面"];
    
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:ciTiao];
    NSString * requestAddress = [[NSString alloc] initWithFormat:@"http://image.baidu.com/search/index?tn=baiduimage&word=%@",[url relativeString]];
//    NSLog(@"%@",requestAddress);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //默认解析成json  设置解析成nsdata
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:requestAddress
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             
             NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             if (!str){NSLog(@"地址%@没有获取到数据",url); return;}
             
             //***********查找***********
             NSString *regexString = @"\"objURL\":\"(.*?)\"";//10
             //              NSString *regexString = @"\"objURL\":\"(.*?)\"";
             NSRegularExpression * regex = [[NSRegularExpression alloc]initWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
             [regex enumerateMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                 if (result) {
                     //   *stop = YES;//为空停止查找
                     //查找到的内容
                     NSString* str2 = [str substringWithRange:result.range];
                     str2 = [str2 substringWithRange:NSMakeRange(10, str2.length-11)];
                     //gif先剔除
                     if ([[str2 substringFromIndex:str2.length-3] isEqualToString:@"gif"]) {return;}
//                     NSLog(@"imageURL:%@",str2);
                     
                     NSString* nowimage = [DMlist getImageCache:ciTiao];
                     //排除当前封面
                     if ([str2 isEqualToString:nowimage]) {
                         return;
                     }
            
                     [imageArr addObject:str2];
                     Huidiao(str2);
                 }
                 
                     
                 
                 
             } ];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
         }];
    
    
    


    return nil;
}








@end
