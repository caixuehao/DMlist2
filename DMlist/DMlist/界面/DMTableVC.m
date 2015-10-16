//
//  DMTableVC.m
//  DMlist
//
//  Created by duole on 15/10/16.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "DMTableVC.h"
#import  "DMCollectionViewCell.h"

@interface DMTableVC ()

@end

@implementation DMTableVC
-(DMTableVC*)initDIC:(NSMutableDictionary *)DIC{
    self = [super init];
    if (self) {
        _FZDIC = DIC;
        //初始化
        _DMARR = [_FZDIC objectForKey:@"元素数组"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //====数据===

    //====UI====
    //导航栏
    
    //集合视图
    _w = ([[UIScreen mainScreen] bounds].size.width-30)/2;
    [_MainCollectionView registerClass:[DMCollectionViewCell class] forCellWithReuseIdentifier:@"DMCell"];//注册Cell
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//=====================================================================================================================
//===================================================collectionView=================================================
//=====================================================================================================================
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _DMARR.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义每个UICollectionView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(_w, _w*1.5);
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //正常单元格
    DMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DMCell" forIndexPath:indexPath];
    NSMutableDictionary *dic = _DMARR[indexPath.row];
    [cell setData:dic];
    
    return cell;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
