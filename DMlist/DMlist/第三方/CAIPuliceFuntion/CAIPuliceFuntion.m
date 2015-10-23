//
//  CAIPuliceFuntion.m
//  DMlist
//
//  Created by duole on 15/9/10.
//  Copyright (c) 2015年 duole. All rights reserved.
//

#import "CAIPuliceFuntion.h"
#import "UIImageView+WebCache.h"



static CAIPuliceFuntion* CAIpt;
@implementation CAIPuliceFuntion

UIActivityIndicatorView *indicator2;
UIView *view2;

+(CAIPuliceFuntion*)sharedCAI{
    if (!CAIpt)     CAIpt = [[CAIPuliceFuntion alloc] init];
    return CAIpt;
}
//888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
+(void)showMessage:(NSString *)message
{
    
    int w = [[UIScreen mainScreen] bounds].size.width;
    int h = [[UIScreen mainScreen] bounds].size.height;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((w - LabelSize.width - 20)/2, h - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:1.5 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}
//888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
-(void)DownloadImage:(NSString *)url{
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[[NSURL alloc]initWithString:url] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        NSLog(@"%ld %ld",(long)receivedSize,(long)expectedSize);
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if(error){
            [CAIPuliceFuntion showMessage:@"保存失败"];return;
        }
        else{
            [CAIPuliceFuntion showMessage:@"保存成功"];
        }
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)(^(NSURL* assetURL, NSError* error) {
            if (error!=nil) {
                return;
            }
        }));
        
    }];
}

//保存结束回调
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
  
}


//888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
-(void)addAlbum{
   
    
//    http://www.itstrike.cn/Question/2ad0e65d-b949-4c7b-8e76-00690aa3d9a7.html
//    http://www.iashes.com/2015-03-544.html
/*
     ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    //获取权限成功之后该干的事
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {

                [assetsLibrary addAssetsGroupAlbumWithName:@"动漫3"
                                               resultBlock:^(ALAssetsGroup *group)
                 {

                    [self showMessage:@"创建相册成功"];
                     
                 }
                failureBlock:^(NSError* error){
                    [self showMessage:@"创建相册失败"];
                            
                }];
  
    };
    //创建相簿
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupLibrary usingBlock:listGroupBlock failureBlock:^(NSError* error){
         [self showMessage:@"创建相册失败,没有权限"];
    }];
*/

}
//888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
+(void)showFHL{
    int w = [[UIScreen mainScreen] bounds].size.width;
    int h = [[UIScreen mainScreen] bounds].size.height;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    //    showview.backgroundColor = [UIColor whiteColor];
    showview.frame = [[UIScreen mainScreen] bounds];
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    //初始化:
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    indicator.tag = 103;
    
    //设置显示样式,见UIActivityIndicatorViewStyle的定义
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    
    //设置背景色
    //        indicator.backgroundColor = [UIColor blackColor];
    
    //设置背景透明
    indicator.alpha = 1;
    
    //设置背景为圆角矩形
    indicator.layer.cornerRadius = 6;
    indicator.layer.masksToBounds = YES;
    //设置显示位置
    [indicator setCenter:CGPointMake(w/ 2.0, h/ 2.0)];
    
    //开始显示Loading动画
    [indicator startAnimating];
    indicator2 = indicator;
    view2 = showview;
    [showview addSubview:indicator];
    
}

+(void)stopFHL{
    if (indicator2) {
        [indicator2 stopAnimating];
        [view2 removeFromSuperview];
    }
    
}
//888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

+ (UIImage *)setImageSize:(UIImage *)img size:(CGSize)newsize{
    // 创建一个bitmap的context
//    newsize.width*=2;
//    newsize.height*=2;
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
