//
//  ESStartView.m
//  DMlist
//
//  Created by 云之彼端 on 15/10/14.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "ESStartView.h"
#import "AppDelegate.h"
#import "MainImage.h"
@implementation ESStartView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)dealloc {
    NSLog(@"dealloc:%@", [[self class] description]);
}

+(void)show; {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIView *view = app.window.rootViewController.view;
    [view addSubview:[[ESStartView alloc] initWithFrame:view.bounds]];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.image = [UIImage imageNamed:@"saber"];
        [MainImage setImageView:imageView IamgeType:@"启动图"];//cai--
        imageView.alpha = 0.0;
        [self addSubview:imageView];
        
        
        [UIView animateWithDuration:1.2 animations:^{
            imageView.alpha = 1;
        }];
        
        [GCD AfterDelayWithMainQueue:3000 block:^{
            [UIView animateWithDuration:1.2 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
        
    }
    return self;
}


@end
