//
//  addDMVC.h
//  DMlist
//
//  Created by duole on 15/10/21.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMTableVC.h"

@interface addDMVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UILabel *nameErrorLabel;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;

@property (nonatomic, strong) DMTableVC* DMVC;

-(id)initWithDMVC:(DMTableVC*)DMVC;
@end
