//
//  addFenZuVC.m
//  DMlist
//
//  Created by duole on 15/10/20.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "addFenZuVC.h"
#import "UIViewController+MaryPopin.h"
#import "CAIPuliceFuntion.h"
#import "DMlist.h"
#import "AppDelegate.h"
#import "FZlistVC.h"

@interface addFenZuVC ()

@end

@implementation addFenZuVC
-(id)init{
    self = [super self];
    if (self) {
        
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
- (IBAction)确定按钮:(id)sender {
    BOOL bl = YES;
    //判断两个是否为空
    if(_nameTF.text.length == 0){
        bl = NO;
        _nameErrorLabel.text= @"用户名不能为空!";
        [CAIPuliceFuntion showMessage:@"用户名不能为空!"];
    }
    if(_typeTF.text.length == 0){
        bl = NO;
        _typeErrorLabel.text = @"标识符不能为空!";
        [CAIPuliceFuntion showMessage:@"标识符不能为空!"];
    }
    
    //判断标识符是重复
    for(NSMutableDictionary* dic in [DMlist Get_DMlistArr]){
        NSString* str = [dic objectForKey:@"标识符"];
        if([str isEqualToString:_typeTF.text]){
            _typeErrorLabel.text = @"标识符重复!";
            [CAIPuliceFuntion showMessage:@"标识符重复!"];
            return;
        }
    }
    
    if(bl){
        [CAIPuliceFuntion showFHL];
        [DMlist addF_name:_nameTF.text remark:_remarkTV.text type:[_typeTF.text intValue] titleImageUrl:@"" FZ:1 Success:^{
            
            [CAIPuliceFuntion stopFHL];
            [CAIPuliceFuntion showMessage:@"添加成功"];
            //刷新界面
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            UINavigationController* nvc = (UINavigationController*)app.window.rootViewController;
            FZlistVC* fvc = (FZlistVC*)nvc.viewControllers[0];
//            fvc.FZARR = [DMlist Get_DMlistArr];
            [fvc.MainCollectionView reloadData];
            
            
        } Fail:^(NSInteger i) {
            [CAIPuliceFuntion stopFHL];
            [CAIPuliceFuntion showMessage:@"添加失败"];
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _nameErrorLabel.text = @"";
    _typeErrorLabel.text = @"";
    _remarkTV.text = @"";
    
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_remarkTV resignFirstResponder];
    [_nameTF resignFirstResponder];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [_remarkTV resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [_nameTF resignFirstResponder];
    return YES;
}

//限制只可以输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 250) {
         if(string.length !=0) _typeErrorLabel.text = @"";
        return [self validateNumber:string];
    }
    if(string.length !=0) _nameErrorLabel.text = @"";
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
@end
