//
//  DMReviseVC.m
//  DMlist
//
//  Created by duole on 15/10/22.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "DMReviseVC.h"
#import "DMlist.h"
#import "CAIPuliceFuntion.h"
@interface DMReviseVC ()

@end

@implementation DMReviseVC
-(id)initWithData:(NSMutableDictionary *)DIC{
    self = [super init];
    if (self) {
        _DM_DIC = DIC;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //ui
    _MainScr.contentSize = CGSizeMake(0, _MainScr.contentSize.height);//禁止左右滑动
    _MainScr.showsVerticalScrollIndicator = FALSE;
    _MainScr.showsHorizontalScrollIndicator = FALSE;
    
    //数据
    _nameTF.text = [_DM_DIC objectForKey:@"名字"];
    _remarkTV.text = [_DM_DIC objectForKey:@"备注"];
    _IDlabel.text = [_DM_DIC objectForKey:@"ID"];
    for(int i = 0 ;i < [DMlist Get_DMlistArr].count;i++){
        NSString *str1 = [[DMlist Get_DMlistArr][i] objectForKey:@"标识符"];
        NSString *str2 = [_DM_DIC objectForKey:@"标识符"];
        if ([str1 isEqualToString:str2]) {
            [_typePic selectRow:i inComponent:0 animated:YES];
        }
    }
}
- (IBAction)确认添加:(id)sender {
    [CAIPuliceFuntion showFHL];
   NSString* type = [[DMlist Get_DMlistArr][[_typePic selectedRowInComponent:0] ] objectForKey:@"标识符"];
    
    [DMlist setF_ID:_IDlabel.text Name:_nameTF.text remark:_remarkTV.text type:[type intValue] titleImageUrl:nil Success:^{
        [CAIPuliceFuntion stopFHL];
        [CAIPuliceFuntion showMessage:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } Fail:^(NSInteger i) {
        [CAIPuliceFuntion stopFHL];
        [CAIPuliceFuntion showMessage:@"修改失败"];
    }];
    
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
//点击边框关掉键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_remarkTV resignFirstResponder];
    [_nameTF resignFirstResponder];
}
#pragma mark -
#pragma mark Picker Data Source Methods
//设置pickerView的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//设置每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    
    return [DMlist Get_DMlistArr].count;
    
}

//设置每行每列的内容
#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    NSString* str = [[DMlist Get_DMlistArr][row] objectForKey:@"分组名"];
    return str;
}

@end
