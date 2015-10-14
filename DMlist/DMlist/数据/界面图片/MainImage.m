//
//  MainImage.m
//  DMlist
//
//  Created by duole on 15/10/12.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "MainImage.h"
#import <BmobSDK/Bmob.h>
#import "UIImageView+WebCache.h"


NSMutableDictionary* ImageDIC;

@implementation MainImage


+(void)setImageView:(UIImageView *)iv IamgeType:(NSString *)type{
    //第一次进入时从本地读一遍
    if(ImageDIC == nil){
        [MainImage readImageDIC];
    }

    NSDictionary* dic = [ImageDIC valueForKey:type];
    NSString* URLstr = [dic valueForKey:@"图片地址"];
    
    if(URLstr.length == 0){
        //本地没有type类型的图片
    }else{
        //如果本地有直接设置
//         [iv sd_setImageWithURL:[self pathtype:type] placeholderImage:iv.image];
        iv.image = [UIImage imageNamed:[self pathtype:type]];
    }
    //同步数据
    [self updata];
}
//同步数据
+(void)updata{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Image"];
    //查询整个表
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        BmobObject *bobj =  nil;
        NSString *path;
        NSString* type;
        for (BmobObject *obj in array) {
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
           
            //获取图片路径
            BmobFile*  dic = [obj objectForKey:@"image"];
            path = [dic url];
            if (path.length == 0) {
                //如果数据库没有看看imageUrl里有没有
                path = [obj objectForKey:@"imageUrl"];
            }
            
            //查看服务器是否有更新
            type = [obj objectForKey:@"type"];
            NSInteger i1 = [[[ImageDIC valueForKey:type] valueForKey:@"图片编号"] intValue];//本地的编号
            NSInteger i2 = [[obj objectForKey:@"number"] intValue];//数据库的编号
            if ( i1 < i2) {
                bobj = obj;

            }
//88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
        }
        
        if(bobj){
            //服务器有更新开始获取和保存图片
             NSLog(@"%@开始成功",type);
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[[NSURL alloc]initWithString:path] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                //        NSLog(@"%ld %ld",(long)receivedSize,(long)expectedSize);
            } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if(error){
                    NSLog(@"保存失败");return;
                }
                else{
                    //                        //保存成功
                    NSDictionary *dic = @{@"图片编号":[bobj objectForKey:@"number"],@"图片地址":path};
                    NSLog(@"%@更新成功",type);
                    [ImageDIC setValue:dic forKey:[bobj objectForKey:@"type"]];
                    [self writeImageDIC];
                    [data writeToFile:[self pathtype:type] atomically:YES];
                    
                }
                
            }];
        }
    }];

}
//返回保存图片的路径
+(NSString*)pathtype:(NSString*) type{
    type = [type stringByAppendingFormat:@".png"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *plistPath = [paths objectAtIndex:0];
    plistPath=[plistPath stringByAppendingPathComponent:type];
    
    return plistPath;
}

+(void)readImageDIC{
    //读
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *plistPath=[plistPath1 stringByAppendingPathComponent:@"images.plist"];
  
    ImageDIC = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //如果本地没有plist文件
    if (ImageDIC == nil) {
        //自己新建一个
        NSDictionary* dic =  @{@"启动图":@{@"图片地址":@"",@"图片编号":@0}};
        ImageDIC = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
//  NSLog(@"%@",DIC);
}

//本地化
+(void)writeImageDIC{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"images.plist"];
    
    [ImageDIC writeToFile:filename atomically:YES];
}

@end
