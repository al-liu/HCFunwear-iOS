//
//  ProductDetailViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "HCTopGoodsDetailView.h"
#import "Masonry.h"
#import "HCShoppingCartView.h"
#import "HCGoodsDetailRefreshFooter.h"
#import "HCBottomGoodsDetailView.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (instancetype)initWithViewModel:(ProductDetailViewModel *)viewModel {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    /*
    HCTopGoodsDetailView *goodsDetailView = [HCTopGoodsDetailView new];
    [self.view addSubview:goodsDetailView];
    
    [goodsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);

    }];
    */
    
    HCBottomGoodsDetailView *bottomGoodsView = [HCBottomGoodsDetailView new];
    [self.view addSubview:bottomGoodsView];
    
    [bottomGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    
    HCShoppingCartView *shoppingCartView = [HCShoppingCartView new];
    [self.view addSubview:shoppingCartView];
    
    [shoppingCartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
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
