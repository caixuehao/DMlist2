//
//  addFenZuVC.h
//  DMlist
//
//  Created by duole on 15/10/20.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addFenZuVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UILabel *nameErrorLabel;
@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UILabel *typeErrorLabel;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;

@end
