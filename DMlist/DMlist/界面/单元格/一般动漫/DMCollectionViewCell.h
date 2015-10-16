//
//  CollectionViewCell.h
//  DMlist
//
//  Created by duole on 15/9/2.
//  Copyright (c) 2015年 duole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)  UIImageView *imageview;
@property (strong, nonatomic) UILabel *Label;
@property (strong, nonatomic) UIImageView *Namebg;

- (id)initWithFrame:(CGRect)frame;

- (void)setData:(NSMutableDictionary*)DIC;

@end
