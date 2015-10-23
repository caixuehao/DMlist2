//
//  imageViewController.h
//  DMlist
//
//  Created by duole on 15/9/17.
//  Copyright (c) 2015年 duole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageViewController : UIViewController
@property(nonatomic,strong)UIImage* image;
@property(nonatomic,strong)NSString* imagePath;
@property(nonatomic,strong)NSMutableDictionary* DIC;

-(id)initWithImageURL:(NSString*)url;
-(id)initWithImage:(UIImage*)image Data:(NSMutableDictionary*)DIC imagePath:(NSString*)path;
@end
