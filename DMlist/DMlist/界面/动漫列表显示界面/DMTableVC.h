//
//  DMTableVC.h
//  DMlist
//
//  Created by duole on 15/10/16.
//  Copyright © 2015年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMTableVC : UIViewController<UISearchBarDelegate>
@property (nonatomic,strong) NSMutableDictionary* FZDIC;//分组信息
@property (nonatomic,strong) NSMutableArray* DMARR;//动漫信息数组

@property (nonatomic,strong) UISearchBar* search;//搜索栏

@property (weak, nonatomic) IBOutlet UICollectionView *MainCollectionView;
@property (assign,nonatomic)float  w;//单元格宽度

-(DMTableVC*)initDIC:(NSMutableDictionary*)DIC;



@end
