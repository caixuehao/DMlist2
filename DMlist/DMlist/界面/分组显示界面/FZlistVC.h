//
//  FZlistVC.h
//  DMlist
//
//  Created by duole on 15/10/13.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZlistVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *MainCollectionView;

@property (nonatomic,strong) NSMutableArray* FZARR;//分组信息数组
@property (assign,nonatomic) float w;//单元格宽度
@end
