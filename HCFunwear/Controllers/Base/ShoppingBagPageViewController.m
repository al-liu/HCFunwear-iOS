//
//  ShoppingBagPageViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ShoppingBagPageViewController.h"
#import "GlobalContext.h"
#import "ShoppingBagNoGoodsView.h"
#import "Masonry.h"

@interface ShoppingBagPageViewController ()

@end

@implementation ShoppingBagPageViewController

#pragma mark - life_cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configNavigationBar];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.title = @"购物车";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    ShoppingBagNoGoodsView *noGoodsView = ({
        ShoppingBagNoGoodsView *view = [ShoppingBagNoGoodsView new];
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
        }];
        
        view;
    });
}

#pragma mark - configration
- (void)configNavigationBar {
    
    
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = nil;
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = nil;
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.titleView = nil;
}

@end
