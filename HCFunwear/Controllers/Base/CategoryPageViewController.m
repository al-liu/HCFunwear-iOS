//
//  CategoryPageViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "CategoryPageViewController.h"
#import "GlobalContext.h"
#import "TopCategoryView.h"

@interface CategoryPageViewController () {
    TopCategoryView *topView;
}

@end

@implementation CategoryPageViewController

#pragma mark - life_cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = screenSize.width;
    topView = [[TopCategoryView alloc]initWithFrame:CGRectMake(0, 0, screenWidth-180, 44)];
    topView.delegate = self;
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
    [leftButton setImage:[UIImage imageNamed:@"top_cebian"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 58, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = rightItem;
    
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.titleView = topView;
}

#pragma mark - TopCategoryViewDelegate
- (NSString *)topCategoryView:(TopCategoryView *)topCategoryView labelForTitleAtIndex:(NSInteger)index {
    NSArray *titleArray = @[@"热门",@"品类",@"品牌"];
    return titleArray[index];
}

- (void)topCategoryView:(TopCategoryView *)topCategoryView clickAtIndex:(NSInteger)index {
    
}


@end
