//
//  LoginVC.m
//  DMlist
//
//  Created by duole on 15/10/13.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "LoginVC.h"
#import "UserInfo.h"
#import "FZlistVC.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //先判断是否自动登录
    BOOL bl = [UserInfo autologin];
    //获取已经成功登录过的账号
    NSMutableArray* userArr = [UserInfo Users];
    NSLog(@"%@",userArr);
    NSMutableDictionary* dic = userArr[0];
    //同步输入框
    _usernameTF.text = [dic valueForKey:@"用户名"];
    _passwordTF.text = [dic valueForKey:@"密码"];
    //如果没有账号离线登录按钮不能点
    
    //如果是自动登录
    if (bl) {
        //验证第一个账号的密码账号
 
        [UserInfo LoginUsername:[dic valueForKey:@"用户名"] Password:[dic valueForKey:@"密码"] Success:^{
            NSLog(@"登录成功");
            self.view.window.rootViewController = [[FZlistVC alloc] init];
        } Fail:^(int i) {
            NSLog(@"登录失败");//0 == 没有这个账号  1 == 密码错误
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)登录:(id)sender {
    [UserInfo LoginUsername:_usernameTF.text Password:_passwordTF.text Success:^{
        NSLog(@"登录成功");
        self.view.window.rootViewController = [[FZlistVC alloc] init];
    } Fail:^(int i) {
        NSLog(@"登录失败");//0 == 没有这个账号  1 == 密码错误
    }];

}
- (IBAction)离线登录:(id)sender {
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
