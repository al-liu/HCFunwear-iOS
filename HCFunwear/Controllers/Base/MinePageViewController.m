//
//  MinePageViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MinePageViewController.h"
#import "GlobalContext.h"
#import "MinePageView.h"
#import "Masonry.h"
#import "MinePageViewModel.h"

@interface MinePageViewController ()
{
    MinePageViewModel *_minePageViewModel;
}
@end

@implementation MinePageViewController

#pragma mark - life_cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _minePageViewModel = [MinePageViewModel new];
    [self initUI];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - configration
- (void)configNavigationBar {
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 58);
    [leftButton setImage:[UIImage imageNamed:@"top_set"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 58, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_message2"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = rightItem;
    
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.titleView = nil;
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.title = @"我的";
}

- (void)initUI {
    MinePageView *pageView = ({
        MinePageView *view = [MinePageView new];
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
        }];
        
        view;
    });
    pageView.minePageMenus = _minePageViewModel.mineMenuModels;
    pageView.minePageOrderMenus = _minePageViewModel.mineOrderMenuModels;
    
    [pageView reloadData];
}

@end
