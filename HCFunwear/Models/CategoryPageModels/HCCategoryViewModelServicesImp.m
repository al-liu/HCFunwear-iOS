//
//  HCCategoryViewModelServicesImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCCategoryViewModelServicesImp.h"
#import "HCCategoryApiServicesImpl.h"

#import "HCWebViewModel.h"
#import "ProductDetailViewModel.h"

#import "HCWebViewController.h"
#import "GlobalContext.h"

#import "ProductDetailViewController.h"

@interface HCCategoryViewModelServicesImp ()

@property (nonatomic, strong) HCCategoryApiServicesImpl *cateServiceImpl;

@end

@implementation HCCategoryViewModelServicesImp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cateServiceImpl = [HCCategoryApiServicesImpl new];
    }
    return self;
}

- (id<HCCategoryApiServices>)getCategoryApiService {
    return self.cateServiceImpl;
}

- (void)pushViewModel:(__nullable id)viewModel animated:(BOOL)animated {
    //跳转逻辑
    [super pushViewModel:viewModel animated:animated];
}

@end
