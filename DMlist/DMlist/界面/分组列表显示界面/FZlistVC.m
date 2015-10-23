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
#import "CAIPuliceFuntion.h"
#import "addFenZuVC.h"
#import "UIViewController+MaryPopin.h"

@interface FZlistVC ()

@end

@implementation FZlistVC
//显示视图时调用刷新
- (void)viewWillAppear:(BOOL)animated{
    [_MainCollectionView reloadData];
//    self.navigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem ;
//    self.navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem ;
}

//用户信息按钮
- (void)leftbtn:(id)sender {
    NSString *str = [[NSString alloc]initWithFormat:@"%@(%@)",[UserInfo share].nickname,[UserInfo share].username];
    
   UIAlertController* alervc = [UIAlertController alertControllerWithTitle:str message:@"切换其他账号登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"切换账号" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"切换账号");
        [self.navigationController pushViewController:[[LoginVC alloc] init] animated:YES];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];

    [alervc addAction:cancelAction];
    [alervc addAction:okAction];
    [self presentViewController:alervc animated:YES completion:nil];
}

//增加分组按钮
-(void)rightbtn:(id)sender{
     [self.navigationController presentPopinController:[[addFenZuVC alloc] init] animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//====数据===
    //初始化
    _FZARR = [[NSMutableArray alloc] init];
    
    
    
//====UI====
    //导航栏
        //背景
    CGSize titleSize = self.navigationController.navigationBar.bounds.size;
//    UIImage* bgimage = [UIImage imageNamed:@"acfun.jpg"];
//    [self.navigationController.navigationBar setBackgroundImage:[CAIPuliceFuntion setImageSize:bgimage size:titleSize] forBarMetrics:UIBarMetricsDefault];
    UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bilibili"]];
    iv.frame = CGRectMake(35, 0, titleSize.width-70, titleSize.height);
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [self.navigationController.navigationBar addSubview:iv];
        //返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
        //用户信息按钮
    UIBarButtonItem *leftBtn =    [[UIBarButtonItem alloc] initWithTitle:@"账号" style:UIBarButtonItemStylePlain target:self action:@selector(leftbtn:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
        //增加分组按钮
    UIBarButtonItem *rightBtn =    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //集合视图
    _w = ([[UIScreen mainScreen] bounds].size.width-30)/2;
    [_MainCollectionView registerClass:[FenZuCell class] forCellWithReuseIdentifier:@"FenZuCell"];//注册Cell
    
    
    
    
//====逻辑====
    //先判断是否自动登录
    BOOL bl = [UserInfo autologin];
    NSMutableArray* userArr = [UserInfo Users];
    if (bl) {
        [CAIPuliceFuntion showFHL];//开始转风火轮
        //验证第一个账号的密码账号
        NSMutableDictionary* dic = userArr[0];
        [UserInfo LoginUsername:[dic valueForKey:@"用户名"] Password:[dic valueForKey:@"密码"] Success:^{
            
        
            [DMlist GetFZList:^(NSMutableArray *arr) {
                _FZARR = arr;
                 [_MainCollectionView reloadData];
             [CAIPuliceFuntion showMessage:@"登录成功"];
//            [CAIPuliceFuntion showMessage:@"数据刷新成功"];
                [CAIPuliceFuntion stopFHL];//停止

            }];
            
        } Fail:^(int i) {
            [CAIPuliceFuntion showMessage:@"登录失败"];//0 == 没有这个账号  1 == 密码错误
            [CAIPuliceFuntion stopFHL];//停止
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
