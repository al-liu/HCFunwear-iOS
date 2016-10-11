//
//  HCProductDetailViewModelServiceImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailViewModelServiceImp.h"
#import "HCProductDetailApiServiceImp.h"
#import "HCWebViewModel.h"
#import "HCWebViewController.h"
#import "GlobalContext.h"

@interface HCProductDetailViewModelServiceImp ()

@property (nonatomic, strong) HCProductDetailApiServiceImp *productDetailServiceImpl;

@end

@implementation HCProductDetailViewModelServiceImp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _productDetailServiceImpl = [HCProductDetailApiServiceImp new];
    }
    return self;
}

- (id<HCProductDetailApiService>)getProductDetailApiService {
    return self.productDetailServiceImpl;
}

- (void)pushViewModel:(__nullable id)viewModel animated:(BOOL)animated {
    //跳转逻辑
    if ([viewModel isKindOfClass:HCWebViewModel.class]) {
        HCWebViewController *webViewController = [[HCWebViewController alloc] initWithViewModel:viewModel];
        [[GlobalContext ShareInstance].rootController pushViewController:webViewController animated:YES];
    }
}

@end
