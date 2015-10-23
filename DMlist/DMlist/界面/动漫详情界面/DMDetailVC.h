//
//  DMDetailVC.h
//  DMlist
//
//  Created by duole on 15/10/20.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMDetailVC : UIViewController<UIScrollViewDelegate,UITextViewDelegate>
-(id)initWithData:(NSMutableDictionary*)DIC;

@property(nonatomic,strong) NSMutableDictionary* DM_DIC;

@property (strong, nonatomic) UIScrollView *MainScrView;//主滚动视图
@property (strong, nonatomic) UILabel* nameLabel;//名字
@property (strong, nonatomic) UIScrollView *ImagesScr;//图片
@property (strong, nonatomic) UILabel* imageSizeLabel;//图片大小
@property (strong, nonatomic) UITextView *remarkTV;//备注


@property(strong, nonatomic) NSMutableArray* imagesURL_ARR;//图片数组
@property(assign, nonatomic) NSInteger nowImagesCount;//已经加载出的图片数量 初始值 0
@property(assign, nonatomic) NSInteger nowImageNumber;//当前的图片  初始值 0
@property(strong, nonatomic) NSMutableArray* imageviews_ARR;

@end
