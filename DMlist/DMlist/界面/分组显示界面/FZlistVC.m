//
//  FZlistVC.m
//  DMlist
//
//  Created by duole on 15/10/13.
//  Copyright © 2015年 cai. All rights reserved.
//

#import "FZlistVC.h"
#import "DMlist.h"
@interface FZlistVC ()

@end

@implementation FZlistVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    [DMlist GetFZList:^(NSMutableArray *arr) {
//        NSLog(@"%@",arr);
        for (NSMutableDictionary *dic in [arr[0] valueForKey:@"元素数组"]) {
            NSLog(@"%@",[dic valueForKey:@"名字"]);
        }
    }];
//    [DMlist addF_name:@"一周的朋友" remark:@"测试" type:4 titleImageUrl:@"" FZ:0 Success:nil Fail:nil];
}
- (IBAction)btn1:(id)sender {
//    [DMlist addF_name:_tf1.text remark:@"测试" type:4 titleImageUrl:@"" FZ:0 Success:^{
//        [DMlist GetFZList:^(NSMutableArray *arr) {
//            NSLog(@"%@",arr);
//        }];
//    } Fail:nil];
//    [DMlist removeF:@"一周的朋友2" Success:nil Fail:nil];
    [DMlist GetFZList:^(NSMutableArray *arr) {
        //        NSLog(@"%@",arr);
        for (NSMutableDictionary *dic in [arr[0] valueForKey:@"元素数组"]) {
            NSLog(@"%@",[dic valueForKey:@"名字"]);
        }
    }];
    [DMlist setF_oldname:@"08f4fca3e9" Name:_tf1.text remark:nil type:4 titleImageUrl:nil Success:nil Fail:nil];
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

@end
