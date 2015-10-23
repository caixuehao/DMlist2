//
//  setFenZuVC.h
//  DMlist
//
//  Created by duole on 15/10/19.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setFenZuVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *typeStr;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UISwitch *setSwitch;
@property (weak, nonatomic) IBOutlet UIButton *setbtn;

@property (strong, nonatomic)  NSMutableDictionary *DIC;

-(setFenZuVC*)initWithDIC:(NSMutableDictionary*)DIC;

@end
