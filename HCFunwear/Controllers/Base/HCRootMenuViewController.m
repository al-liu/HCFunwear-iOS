//
//  HCRootMenuViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCRootMenuViewController.h"
#import "GlobalImport.h"
#import "Masonry.h"
#import "MainStyleView.h"

@interface HCRootMenuViewController ()

@end

@implementation HCRootMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:btn];
    
    MainStyleView *styleView = [[MainStyleView alloc]init];
    [self.view addSubview:styleView];
    
    [styleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[GlobalContext ShareInstance].rootController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[GlobalContext ShareInstance].rootController setNavigationBarHidden:NO animated:animated];
}

- (void)nextAction {
    [self.navigationController pushViewController:[GlobalContext ShareInstance].mainTabBarController animated:YES];
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
