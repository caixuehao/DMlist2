//
//  addDMVC.m
//  DMlist
//
//  Created by duole on 15/10/21.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "addDMVC.h"
#import "UIViewController+MaryPopin.h"
#import "CAIPuliceFuntion.h"
#import "DMlist.h"

@interface addDMVC ()

@end

@implementation addDMVC

-(id)initWithDMVC:(DMTableVC*)DMVC{
    self = [super self];
    if (self) {
        _DMVC = DMVC;
        
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


- (IBAction)确定添加:(id)sender {
    if(_nameTF.text.length == 0){
        _nameErrorLabel.text= @"不能为空!";
        [CAIPuliceFuntion showMessage:@"名字不能为空!"];
        return;
    }
    [CAIPuliceFuntion showFHL];
    NSInteger type = [[_DMVC.FZDIC objectForKey:@"标识符"] intValue];
    
    [DMlist addF_name:_nameTF.text remark:_remarkTV.text type:type titleImageUrl:@"" FZ:0 Success:^{
        [CAIPuliceFuntion stopFHL];
        [CAIPuliceFuntion showMessage:@"添加成功"];
        
        for(NSMutableDictionary *dic in [DMlist Get_DMlistArr]){
            NSString *str1 = [_DMVC.FZDIC objectForKey:@"标识符"];
            NSString *str2 = [dic objectForKey:@"标识符"];
            if([str1 isEqualToString:str2]){
                _DMVC.FZDIC = dic ;
                _DMVC.DMARR = [dic objectForKey:@"元素数组"];
                break;
            }
        }
        
        
        [_DMVC.MainCollectionView reloadData];
    } Fail:^(NSInteger i) {
        [CAIPuliceFuntion stopFHL];
        [CAIPuliceFuntion showMessage:@"添加失败"];

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _nameErrorLabel.text = @"";
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

@end
