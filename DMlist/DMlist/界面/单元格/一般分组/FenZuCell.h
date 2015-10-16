//
//  FenZuCell.h
//  DMlist
//
//  Created by duole on 15/8/27.
//  Copyright (c) 2015年 duole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FenZuCell : UICollectionViewCell
@property (strong, nonatomic)  UILabel *Name;
@property (strong, nonatomic)  UIImageView *Imageview;
@property (strong, nonatomic)  UILabel *count;

- (id)initWithFrame:(CGRect)frame;

- (void)setData:(NSMutableDictionary*)DIC;

@end
