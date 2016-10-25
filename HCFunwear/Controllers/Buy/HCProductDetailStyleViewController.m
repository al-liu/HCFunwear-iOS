//
//  HCProductDetailStyleViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailStyleViewController.h"
#import "ProductDetailStyleView.h"
#import "Masonry.h"
#import "GlobalImport.h"

@interface HCProductDetailStyleViewController ()

@property (nonatomic, strong) HCProductDetailStyleViewModel *productDetailStyleViewModel;

@end

@implementation HCProductDetailStyleViewController

- (instancetype)initWithViewModel:(HCProductDetailStyleViewModel *)viewModel {
    self = [super init];
    if (self) {
        _productDetailStyleViewModel = viewModel;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    ProductDetailStyleView *detailStyleView = [ProductDetailStyleView new];
    [self.view addSubview:detailStyleView];
    
    [detailStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(SCREEN_HEIGHT * 0.31));
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

@end
