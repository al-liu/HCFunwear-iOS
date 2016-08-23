//
//  HCHomeViewModelServiceImpl.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCHomeViewModelServiceImpl.h"
#import "HCHomeLayoutServiceImpl.h"
#import "HCWebViewModel.h"
#import "ProductDetailViewModel.h"
#import "HCWebViewController.h"
#import "GlobalContext.h"
#import "ProductDetailViewController.h"
#import "HCCategoryApiServices.h"
#import "HCCategoryApiServicesImpl.h"
@interface HCHomeViewModelServiceImpl ()

@property (nonatomic, strong) HCHomeLayoutServiceImpl *serviceImpl;
@property (nonatomic, strong) HCCategoryApiServicesImpl *cateServiceImpl;

@end

@implementation HCHomeViewModelServiceImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serviceImpl = [HCHomeLayoutServiceImpl new];
        _cateServiceImpl = [HCCategoryApiServicesImpl new];
    }
    return self;
}

- (id<HCHomeLayoutService>)getHomeLayoutService {
    return self.serviceImpl;
}

- (id<HCCategoryApiServices>)getCategoryApiService {
    return self.cateServiceImpl;
}

- (void)pushViewModel:(id)viewModel {
    //跳转逻辑
    if ([viewModel isKindOfClass:HCWebViewModel.class]) {
        HCWebViewModel *viewModel = [HCWebViewModel new];
        HCWebViewController *webViewController = [[HCWebViewController alloc] initWithViewModel:viewModel];
        [[GlobalContext ShareInstance].rootController pushViewController:webViewController animated:YES];
    }
    else if ([viewModel isKindOfClass:ProductDetailViewModel.class]) {
        ProductDetailViewModel *viewModel = [ProductDetailViewModel new];
        ProductDetailViewController *viewController = [[ProductDetailViewController alloc]initWithViewModel:viewModel];
        [[GlobalContext ShareInstance].rootController pushViewController:viewController animated:YES];
    }
}

@end
