//
//  UIView+Frame.m
//  DMlist
//
//  Created by 云之彼端 on 15/10/14.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (ESFrame)

-(CGFloat)x {
    return self.origin.x;
}
-(void)setX:(CGFloat)x {
    self.origin = CGPointMake(x, self.y);
}

-(CGFloat)y {
    return self.origin.y;
}
-(void)setY:(CGFloat)y {
    self.origin = CGPointMake(self.x, y);
}

-(CGFloat)width {
    return self.size.width;
}
-(void)setWidth:(CGFloat)width {
    self.size = CGSizeMake(width, self.height);
}

-(CGFloat)height {
    return self.size.height;
}
-(void)setHeight:(CGFloat)height {
    self.size = CGSizeMake(self.width, height);
}

-(CGPoint)origin {
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

-(CGSize)size {
    return self.frame.size;
}
-(void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}




@end
