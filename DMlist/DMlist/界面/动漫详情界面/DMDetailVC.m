//
//  DMDetailVC.m
//  DMlist
//
//  Created by duole on 15/10/20.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "DMDetailVC.h"
#import "DMlist.h"
#import "BaiDu.h"
#import "UIImageView+WebCache.h"
#import "CAIPuliceFuntion.h"
#import "DMReviseVC.h"
#import "imageViewController.h"

@interface DMDetailVC ()

@end

@implementation DMDetailVC
-(id)initWithData:(NSMutableDictionary *)DIC{
    self = [super init];
    if (self) {
        _DM_DIC = DIC;
        NSString* imageurl = [DIC valueForKey:@"封面网址"];
        if(imageurl.length == 0){
            imageurl =  [DMlist getImageCache:[DIC objectForKey:@"名字"]];
        }
        _imagesURL_ARR = [[NSMutableArray alloc]initWithObjects:imageurl, nil];
        _nowImageNumber = 0;
        _nowImagesCount = 0;
        _imageviews_ARR = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    float w = [UIScreen mainScreen].bounds.size.width;
//ui
    
    //导航栏
    UIBarButtonItem *delBtn =    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delbtn)];
    UIBarButtonItem *updataBtn =    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(revise)];
    self.navigationItem.rightBarButtonItems = @[delBtn,updataBtn];
        //返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    
    //下面的
    _MainScrView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _MainScrView.contentSize = CGSizeMake(w, 50+300+200);
    _MainScrView.showsVerticalScrollIndicator = FALSE;
    [self.view addSubview:_MainScrView];
    
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, 50)];
    iv.image = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 65, 0, 65)];
    [_MainScrView addSubview:iv];

    _nameLabel = [[UILabel alloc] initWithFrame:iv.frame];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor yellowColor];

    [_MainScrView addSubview:_nameLabel];
    
    
    
    _ImagesScr = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 55, w-10, 290)];
    _ImagesScr.showsHorizontalScrollIndicator = FALSE;//设置滚动条隐藏
    _ImagesScr.pagingEnabled = YES;//设置是否分页
    _ImagesScr.delegate = self; //设置代理
    [self addImageView];
    [_MainScrView addSubview:_ImagesScr];
    
    _imageSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(w-120, 320, 115, 25)];
    _imageSizeLabel.backgroundColor = [UIColor blackColor];
    _imageSizeLabel.alpha = 0.5;
    _imageSizeLabel.textColor = [UIColor greenColor];
    _imageSizeLabel.text = @"????*????";
    [_MainScrView addSubview:_imageSizeLabel];
    
    UIImageView* iv1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, w, 300)];
    iv1.image = [UIImage imageNamed:@"相框"];
    [_MainScrView addSubview:iv1];
    
    
    
    
    UIImageView* iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 350, w, 200)];
    iv2.image = [UIImage imageNamed:@"魔法阵输入背景.jpg"];
    [_MainScrView addSubview:iv2];
    
    _remarkTV = [[UITextView alloc] initWithFrame:CGRectMake(3, 353, w-6, 194)];
    _remarkTV.backgroundColor = [UIColor clearColor];
    _remarkTV.editable = NO;
    [_MainScrView addSubview:_remarkTV];

    
 //数据
    _nameLabel.text = [_DM_DIC objectForKey:@"名字"];
    _remarkTV.text = [_DM_DIC objectForKey:@"备注"];
    
    
    
    NSString* nowimageurl = [_DM_DIC valueForKey:@"封面网址"];
    if(nowimageurl.length == 0){
        nowimageurl =  [DMlist getImageCache:[_DM_DIC objectForKey:@"名字"]];
    }
    
    [BaiDu getImageArr:^(NSString *imageRUL) {
        //排除当前封面
        if ([imageRUL isEqualToString:nowimageurl])return;
        
        [_imagesURL_ARR addObject:imageRUL];
        
        if (_nowImagesCount<3) {
            [self addImageView];
        }
    } CiTiao:[_DM_DIC objectForKey:@"名字"]];
    
    
    
    
    //封面图片单击事件
    _ImagesScr.userInteractionEnabled = YES;
    UITapGestureRecognizer* DanJi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDanJi:)];
    //    DanJi.numberOfTapsRequired = 2;//双击
    [_ImagesScr addGestureRecognizer:DanJi];
}
//单击图片

//单机封面图片
- (void)imageDanJi:(UITapGestureRecognizer *)sender{
    imageViewController *ivc = [[imageViewController alloc] initWithImage:((UIImageView*)(_imageviews_ARR[_nowImageNumber])).image Data:_DM_DIC imagePath:_imagesURL_ARR[_nowImageNumber]];
    [self.navigationController pushViewController:ivc animated:YES];
}
//修改
-(void)revise{

   DMReviseVC* revise = [[DMReviseVC alloc] initWithData:_DM_DIC];
    [self.navigationController pushViewController:revise animated:YES];
    
}
//删除
-(void)delbtn{
    NSString *str = [[NSString alloc]initWithFormat:@"是否删除%@?",[_DM_DIC objectForKey:@"名字"]];
    
    UIAlertController* alervc = [UIAlertController alertControllerWithTitle:@"删除" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定删除" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [CAIPuliceFuntion showFHL];
        [DMlist removeF:[_DM_DIC objectForKey:@"ID"] Success:^{
            
            [CAIPuliceFuntion showMessage:@"删除成功"];
            [CAIPuliceFuntion stopFHL];
            [self.navigationController popViewControllerAnimated:YES];
           
        } Fail:^(NSInteger i) {
            [CAIPuliceFuntion showMessage:@"删除失败"];
            [CAIPuliceFuntion stopFHL];
        }];
 
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"手滑～" style:UIAlertActionStyleDefault handler:nil];
    
    [alervc addAction:cancelAction];
    [alervc addAction:okAction];
    [self presentViewController:alervc animated:YES completion:nil];
}

//增加图片
-(void)addImageView{
    if (_imagesURL_ARR.count <= _nowImagesCount) {
        return;
    }
    NSString* url = _imagesURL_ARR[_nowImagesCount];
    UIImageView* iv = [[UIImageView alloc] initWithFrame:CGRectMake(_ImagesScr.frame.size.width*_nowImagesCount, 0, _ImagesScr.frame.size.width, _ImagesScr.frame.size.height)];
    [iv sd_setImageWithURL:[[NSURL alloc] initWithString:url] placeholderImage:[UIImage imageNamed:@"锁链背景图"]];
    [iv setContentMode:UIViewContentModeScaleAspectFit];
    [_ImagesScr addSubview:iv];
    
    
    _nowImagesCount++;
    _ImagesScr.contentSize = CGSizeMake( _ImagesScr.frame.size.width*_nowImagesCount,_ImagesScr.frame.size.height);
    
    [_imageviews_ARR addObject:iv];
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
//封面视图滑动判断
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _nowImageNumber = (int)(scrollView.contentOffset.x/scrollView.frame.size.width);
    NSInteger ii = _nowImageNumber+3 - _nowImagesCount;
    if (ii>0) {
        while (ii--) {
            [self addImageView];
        }
    }
    UIImageView* iv = _imageviews_ARR[_nowImageNumber];
    UIImage* image = iv.image;
    _imageSizeLabel.text = [[NSString alloc] initWithFormat:@"%.0f*%.0f",image.size.width,image.size.height];

}
@end
