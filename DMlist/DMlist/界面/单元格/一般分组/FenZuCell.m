//
//  FenZuCell.m
//  DMlist
//
//  Created by duole on 15/8/27.
//  Copyright (c) 2015年 duole. All rights reserved.
//

#import "FenZuCell.h"
#import "UIImageView+WebCache.h"

@implementation FenZuCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        _Imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-35)];
        [_Imageview setContentMode:UIViewContentModeScaleAspectFill];
        _Imageview.clipsToBounds = YES;
        [self addSubview:_Imageview];
        
        _Name = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-35, frame.size.width-50, 35)];
        _Name.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_Name];
        
        _count = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-50, frame.size.height-35, 50, 35)];
        [_count setTextColor:[UIColor greenColor]];
        _count.textAlignment = NSTextAlignmentRight;
        [self addSubview:_count];
        
//        [self setBackgroundColor:[UIColor yellowColor]];
    }

    return self;
}
- (void)awakeFromNib {
    // Initialization code
   
}
- (void)setData:(NSMutableDictionary *)DIC{
    NSString* imageurl = [DIC valueForKey:@"封面网址"];
    if (imageurl.length == 0){
        _Imageview.image = [UIImage imageNamed:@"默认分组图.jpg"];
    }else{
        [_Imageview sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"默认分组图.jpg"]];
    }
    
    _Name.text = [DIC valueForKey:@"分组名"];
    
    NSMutableArray* arr = [DIC valueForKey:@"元素数组"];
    _count.text = [[NSString alloc]initWithFormat:@"%ld",arr.count];
}
@end
