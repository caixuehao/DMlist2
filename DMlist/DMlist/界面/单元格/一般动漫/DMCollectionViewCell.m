//
//  CollectionViewCell.m
//  DMlist
//
//  Created by duole on 15/9/2.
//  Copyright (c) 2015年 duole. All rights reserved.
//

#import "DMCollectionViewCell.h"
#import "BaiDu.h"

@implementation DMCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageview = [[UIImageView alloc] initWithFrame:[self bounds]];
        _imageview.image = [UIImage imageNamed:@"锁链背景图"];
        [_imageview setContentMode:UIViewContentModeScaleAspectFill];
        _imageview.clipsToBounds  = YES;
        
        _Label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 25)];
        [_Label setTextAlignment:NSTextAlignmentCenter];
        [_Label setTextColor:[UIColor whiteColor]];
        
        _Namebg = [[UIImageView alloc] initWithFrame:_Label.frame];
        [_Namebg setBackgroundColor:[UIColor blackColor]];
        [_Namebg setAlpha:0.6];
        
        
        [self addSubview:_imageview];
        [self addSubview:_Namebg];
        [self addSubview:_Label];

        
        
    }
    return self;
}

- (void)setData:(NSMutableDictionary*)DIC{

    _Label.text = [DIC valueForKey:@"名字"];
    
    NSString* imageurl = [DIC valueForKey:@"封面网址"];
    if(imageurl.length == 0){
        [BaiDu setFenMian:_imageview CiTiao:_Label.text];
    }
    
//    [BaiDu setFenMian:_imageview CiTiao:StrName];
//    [BaiDu setFenMian3:_imageview CiTiao:StrName];
    

}
- (void)awakeFromNib {
    // Initialization code
}

@end
