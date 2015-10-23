//
//  setFenZuVC.m
//  DMlist
//
//  Created by duole on 15/10/19.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "setFenZuVC.h"
#import "DMlist.h"
#import "AppDelegate.h"
#import "FZlistVC.h"
#import "CAIPuliceFuntion.h"
#import "UIViewController+MaryPopin.h"

@interface setFenZuVC ()

@end

@implementation setFenZuVC
-(setFenZuVC*)initWithDIC:(NSMutableDictionary*)DIC{
    self = [super init];
    if (self) {
    //数据
        _DIC = DIC;
  
    //其他
        [self setPopinTransitionStyle:BKTPopinTransitionStyleSnap]; //设置风格
        BKTBlurParameters *blurParameters = [[BKTBlurParameters alloc] init];
        //blurParameters.alpha = 0.5;
        blurParameters.tintColor = [UIColor colorWithWhite:0 alpha:0.5];
        blurParameters.radius = 0.3;
        [self setBlurParameters:blurParameters];
        [self setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _name.text = [_DIC valueForKey:@"分组名"];
    _remarkTV.text = [_DIC valueForKey:@"备注"];
    _typeStr.text = [_DIC valueForKey:@"标识符"];
    _ID.text = [_DIC valueForKey:@"ID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)是否修改:(id)sender {
    _delBtn.enabled = _setSwitch.on;
    _name.enabled = _setSwitch.on;
    _remarkTV.editable = _setSwitch.on;
    _setbtn.enabled = _setSwitch.on;
    if(_setSwitch.on){
        _remarkTV.alpha = 1.0;
    }else{
        _remarkTV.alpha = 0.8;
    }
}
- (IBAction)确定修改:(id)sender {
      [CAIPuliceFuntion showFHL];
    
    [DMlist setF_ID:_ID.text Name:_name.text remark:_remarkTV.text type:[_typeStr.text intValue] titleImageUrl:nil Success:^{
        [CAIPuliceFuntion showMessage:@"修改成功"];
        //同步数据
        [_DIC setValue:_name.text forKey:@"分组名"];
        [_DIC setValue:_remarkTV.text forKey:@"备注"];
        //刷新界面
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        UINavigationController* nvc = (UINavigationController*)app.window.rootViewController;
        FZlistVC* fvc = (FZlistVC*)nvc.viewControllers[0];
        [fvc.MainCollectionView reloadData];
        [CAIPuliceFuntion stopFHL];

    } Fail:^(NSInteger i) {
        [CAIPuliceFuntion showMessage:@"修改失败"];
        [CAIPuliceFuntion stopFHL];
    }];
    
}
- (IBAction)删除:(id)sender {
    [CAIPuliceFuntion showFHL];
    
        [DMlist removeFZ:_ID.text Success:^{
            [CAIPuliceFuntion showMessage:@"删除成功"];
            //刷新界面
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            UINavigationController* nvc = (UINavigationController*)app.window.rootViewController;
            FZlistVC* fvc = (FZlistVC*)nvc.viewControllers[0];
            fvc.FZARR = [DMlist Get_DMlistArr];
            [fvc.MainCollectionView reloadData];
            
            _setSwitch.on = NO;
            _setSwitch.enabled = NO;
            [self 是否修改:nil];
            [CAIPuliceFuntion stopFHL];
        } Fail:^(NSInteger i) {
            [CAIPuliceFuntion showMessage:@"删除失败"];
            [CAIPuliceFuntion stopFHL];
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_remarkTV resignFirstResponder];
    [_name resignFirstResponder];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [_remarkTV resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [_name resignFirstResponder];
    return YES;
}
@end
