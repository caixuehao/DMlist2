//
//  FZlistVC.m
//  DMlist
//
//  Created by duole on 15/10/13.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "FZlistVC.h"
#import "DMlist.h"
#import "LoginVC.h"
#import "UserInfo.h"
#import "FenZuCell.h"
#import "DMTableVC.h"

@interface FZlistVC ()

@end

@implementation FZlistVC
//显示视图时调用刷新
- (void)viewWillAppear:(BOOL)animated{
    [_MainCollectionView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//====数据===
    //初始化
    _FZARR = [[NSMutableArray alloc] init];
    
    
    
//====UI====
    //导航栏
    CGSize titleSize = self.navigationController.navigationBar.bounds.size;  //获取Navigation Bar的位置和大小
    UIImageView* barbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, titleSize.width, titleSize.height)];
    barbg.image = [UIImage imageNamed:@"acfun.jpg"];
    [self.navigationController.navigationBar addSubview:barbg];
    //集合视图
    _w = ([[UIScreen mainScreen] bounds].size.width-30)/2;
    [_MainCollectionView registerClass:[FenZuCell class] forCellWithReuseIdentifier:@"FenZuCell"];//注册Cell
    
    
    
    
//====逻辑====
    //先判断是否自动登录
    BOOL bl = [UserInfo autologin];
    NSMutableArray* userArr = [UserInfo Users];
    if (bl) {
        //验证第一个账号的密码账号
        NSMutableDictionary* dic = userArr[0];
        [UserInfo LoginUsername:[dic valueForKey:@"用户名"] Password:[dic valueForKey:@"密码"] Success:^{
            
            NSLog(@"登录成功");
            [DMlist GetFZList:^(NSMutableArray *arr) {
                _FZARR = arr;
                 [_MainCollectionView reloadData];
            }];
            
        } Fail:^(int i) {
            NSLog(@"登录失败");//0 == 没有这个账号  1 == 密码错误
            [self.navigationController pushViewController:[[LoginVC alloc] init] animated:YES];
        }];
    }else{
        [self.navigationController pushViewController:[[LoginVC alloc] init] animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CollectionView
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _FZARR.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义每个UICollectionView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(_w, _w);
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    //正常的单元格
    FenZuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FenZuCell" forIndexPath:indexPath];
    [cell setData:_FZARR[indexPath.row]];
    return cell;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DMTableVC* dmvc = [[DMTableVC alloc] initDIC:_FZARR[indexPath.row]];
    [self.navigationController pushViewController:dmvc animated:YES];
}


@end
