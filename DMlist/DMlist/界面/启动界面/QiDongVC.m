//
//  QiDongVC.m
//  DMlist
//
//  Created by duole on 15/10/12.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "QiDongVC.h"
#import "LoginVC.h"
#import "MainImage.h"

@interface QiDongVC ()

@end

@implementation QiDongVC
//-(id)initWithanimate:(void (^)(void))xx{
//    self = [super init];
//    if (self) {
//        _xx = xx;
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iv = [[UIImageView alloc] init];
    iv.center = self.view.center;
    iv.image = [UIImage imageNamed:@"saber"];
    iv.alpha = 0.0;
    [MainImage setImageView:iv IamgeType:@"启动图"];
    //先渐变出来
    [UIView animateWithDuration:0.7 animations:^{
        iv.alpha = 1.0;
        iv.frame = self.view.frame;
    } completion:^(BOOL finished) {
        //再停1秒
        [UIView animateWithDuration:1.5 animations:^{
                iv.alpha = 0.99;
        } completion:^(BOOL finished) {
            //再渐变消失
                [UIView animateWithDuration:0.7 animations:^{
                    iv.alpha = 0.0;
                } completion:^(BOOL finished) {
                    //转场
                    self.view.window.rootViewController = [[LoginVC alloc] init];
                }];
        }];
    }];
    

    
    
    
    
    
    

    
    
    
    
    
    [self.view addSubview:iv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
