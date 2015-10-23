//
//  DMReviseVC.h
//  DMlist
//
//  Created by duole on 15/10/22.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMReviseVC : UIViewController<UITextFieldDelegate>

-(id)initWithData:(NSMutableDictionary*)DIC;

@property(nonatomic,strong) NSMutableDictionary* DM_DIC;

@property (weak, nonatomic) IBOutlet UIScrollView *MainScr;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;
@property (weak, nonatomic) IBOutlet UIPickerView *typePic;
@property (weak, nonatomic) IBOutlet UILabel *IDlabel;

@end
