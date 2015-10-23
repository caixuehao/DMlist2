//
//  imageViewController.m
//  DMlist
//
//  Created by duole on 15/9/17.
//  Copyright (c) 2015年 duole. All rights reserved.
//

#import "imageViewController.h"
#import "VIPhotoView.h"
#import "CAIPuliceFuntion.h"
#import "UIWindow+YUBottomPoper.h"
#import "DMlist.h"

@interface imageViewController ()

@end

@implementation imageViewController
- (id)initWithImageURL:(NSString *)url{
    if (self) {
        _imagePath = url;
    }
    return self;
}
-(id)initWithImage:(UIImage *)image Data:(NSMutableDictionary *)DIC imagePath:(NSString *)path{
    if (self) {
        _image = image;
        _DIC = DIC;
        _imagePath = path;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO]; //隐藏导航栏
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    VIPhotoView *photoView =
//    [[VIPhotoView alloc] initWithFrame:self.view.bounds andImageURL:_imagePath];
    [[VIPhotoView alloc] initWithFrame:self.view.bounds andImage:_image];
    
    
    photoView.autoresizingMask = (1 << 6) -1;
    [self.view addSubview:photoView];
    
    
    
    //单击事件
    UITapGestureRecognizer* DanJi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDanJi:)];
    [self.view addGestureRecognizer:DanJi];
    //长按事件
    UILongPressGestureRecognizer* ChangAn = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imageChangAn:)];
    ChangAn.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:ChangAn];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    //单击事件
- (void)imageDanJi:(UITapGestureRecognizer *)sender{
    [self.navigationController setNavigationBarHidden:NO animated:NO]; //显示导航栏
    [self.navigationController popViewControllerAnimated:YES];
}

  //长按事件
- (void)imageChangAn:(UILongPressGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
//        NSLog(@"长按结束");
        return;//UIGestureRecognizerStateBegan  长按开始
    }

    
    NSMutableArray* titlearr = [[NSMutableArray alloc] initWithObjects:@"保存到相册",@"设置为封面",@"设置为分组封面", nil];
    NSMutableArray* styles = [[NSMutableArray alloc] initWithObjects:YUDefaultStyle,YUDefaultStyle,YUDefaultStyle, nil];;


    [self.view.window  showPopWithButtonTitles:[titlearr copy] styles:[styles copy] whenButtonTouchUpInSideCallBack:^(int index  ) {

        switch (index) {
            case 0:
                UIImageWriteToSavedPhotosAlbum(_image,nil,nil,nil);//保存图片到相册
                [CAIPuliceFuntion showMessage:@"保存图片成功"];//其实我没判断
                break;
                
            case 1:
                [DMlist setF_ID:[_DIC objectForKey:@"ID"] Name:nil remark:nil type:[[_DIC objectForKey:@"标识符"] intValue] titleImageUrl:_imagePath Success:^{
                    [CAIPuliceFuntion showMessage:@"设置成功"];
                } Fail:^(NSInteger i) {
                    [CAIPuliceFuntion showMessage:@"设置失败"];
                }];
                break;

            case 2:
                for (NSMutableDictionary* dic in [DMlist Get_DMlistArr]) {
                    NSString* str1 = [dic objectForKey:@"标识符"];
                    NSString* str2 = [_DIC objectForKey:@"标识符"];

                    if ([str1 isEqualToString:str2]) {
                        [DMlist setF_ID:[dic objectForKey:@"ID"] Name:nil remark:nil type:[[dic objectForKey:@"标识符"] intValue] titleImageUrl:_imagePath Success:^{
                            [CAIPuliceFuntion showMessage:@"设置成功"];
                        } Fail:^(NSInteger i) {
                            [CAIPuliceFuntion showMessage:@"设置失败"];
                        }];
                    }
                }
                break;
            default:
                break;
        }
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
