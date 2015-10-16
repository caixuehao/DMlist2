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
        封面网址:，
//        封面文件:,
        元素数组:,
        ID
    },
    {
    },
    ........
 ]
 //元素
 [
    {
        名字:，
        标识符(属于的分组):，
        备注:，
        封面网址:，
//      封面文件:，
        ID
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
+(void)GetFZList:(void(^)(NSMutableArray* arr)) sucess;
/**
 *修改分组(动漫)信息[对应元素的ID，新名字(可填nil)，新备注(可填nil)，新标识符，新图片网址(可填nil),成功后调用，失败调用];
 */
+(void)setF_oldname:(NSString*)ID Name:(NSString*)name remark:(NSString*)remark type:(NSInteger)type titleImageUrl:(NSString*)titleImageUrl Success:(void(^)())sucess Fail:(void(^)(NSInteger i))fail;

/**
 *上传图片[图片，对应元素的名字]
 */
+(BOOL)UploadImageFile:(UIImage*)image name:(NSString*)name;

/**
 *删除动漫[对应元素的ID,成功后调用，失败调用]
 */
+(void)removeF:(NSString*)ID Success:(void(^)())sucess Fail:(void(^)(NSInteger i))fail;
/**
 *删除分组[对应的ID,成功后调用，失败调用]
 */
+(void)removeFZ:(NSString*)ID Success:(void(^)())sucess Fail:(void(^)(NSInteger i))fail;
/**
 *增加元素［名字，备注，标识符，图片网址，是否是分组,成功后调用，失败调用］
 */
+(void)addF_name:(NSString*)name remark:(NSString*)remark type:(NSInteger)type titleImageUrl:(NSString*)titleImageUrl FZ:(NSInteger)fz Success:(void(^)())sucess Fail:(void(^)(NSInteger i))fail;
/**
 *获取本地封面网址缓存
 */
+(NSString*)getImageCache:(NSString*)ciTiao;
/**
 *添加本地网址缓存
 */
+(void)addImageCache:(NSString*)url  CiTiao:(NSString *)ciTiao;
/**
 *修改本地图片网址缓存
 */
+(void)setImageCache:(NSString*)url CiTioa:(NSString *)ciTiao;
@end
