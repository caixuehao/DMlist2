//
//  DMTableVC.m
//  DMlist
//
//  Created by duole on 15/10/16.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "DMTableVC.h"
#import  "DMCollectionViewCell.h"
#import "addDMVC.h"
#import "UIViewController+MaryPopin.h"
#import "DMDetailVC.h"
#import "DMlist.h"

@interface DMTableVC ()

@end

@implementation DMTableVC

//增加分组按钮
-(void)rightbtn:(id)sender{
    [self.navigationController presentPopinController:[[addDMVC alloc] initWithDMVC:self] animated:YES completion:nil];
}



- (void)viewWillAppear:(BOOL)animated{
    for(NSMutableDictionary *dic in [DMlist Get_DMlistArr]){
        NSString *str1 = [self.FZDIC objectForKey:@"标识符"];
        NSString *str2 = [dic objectForKey:@"标识符"];
        if([str1 isEqualToString:str2]){
            self.FZDIC = dic ;
            self.DMARR = [dic objectForKey:@"元素数组"];
            break;
        }
    }
    [_MainCollectionView reloadData];
}
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
        //返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
        //增加分组按钮
    UIBarButtonItem *rightBtn =    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //集合视图
    //控制header的高度
    _search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    [_search setPlaceholder:@"动漫名字关键字"];
    [_search setDelegate:self];
    [_MainCollectionView addSubview:_search];
    
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout *)_MainCollectionView.collectionViewLayout;
    collectionViewLayout.headerReferenceSize = CGSizeMake(375, 30);
    
    
    _w = ([[UIScreen mainScreen] bounds].size.width-20)/2;
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
    DMDetailVC* dmvc = [[DMDetailVC alloc] initWithData:_DMARR[indexPath.row]];
    [self.navigationController pushViewController:dmvc animated:YES];
}
//=====================================================================================================================
//===================================================UISearchBarDelegate=================================================
//=====================================================================================================================
//点击键盘上的搜索按钮时调用
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_search resignFirstResponder];
    if (_search.text.length == 0) {
        _DMARR =[_FZDIC objectForKey:@"元素数组"];
        [_MainCollectionView reloadData];
        return;
    }
 
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dic in [_FZDIC objectForKey:@"元素数组"]) {
        NSString* str = [dic objectForKey:@"名字"];
        if ([str rangeOfString:_search.text].length > 0) {
            [arr addObject:dic];
        }
    }
    _DMARR = arr ;
    [_MainCollectionView reloadData];
}


//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//
//    if (_search.text.length == 0) {
//        _DMARR =[_FZDIC objectForKey:@"元素数组"];
////        [_MainCollectionView reloadData];
//        [_search resignFirstResponder];
//        return;
//    }
//    
//    NSMutableArray* arr = [[NSMutableArray alloc] init];
//    for (NSMutableDictionary *dic in [_FZDIC objectForKey:@"元素数组"]) {
//        NSString* str = [dic objectForKey:@"名字"];
//        if ([str rangeOfString:_search.text].length > 0) {
//            [arr addObject:dic];
//        }
//    }
//    _DMARR = arr ;
////    [_MainCollectionView reloadData];
//
//}
@end
