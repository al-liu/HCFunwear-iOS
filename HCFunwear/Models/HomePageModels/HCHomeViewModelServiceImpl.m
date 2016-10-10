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
#import "HCTabBarViewModel.h"

#import "HCWebViewController.h"
#import "GlobalContext.h"
#import "ProductDetailViewController.h"
#import "HCCategoryApiServices.h"
#import "HCCategoryApiServicesImpl.h"
#import "HCInspirationApiServiceImpl.h"
#import "HCProductDetailApiServiceImp.h"
#import "HCMainStyleApiServiceImp.h"
@interface HCHomeViewModelServiceImpl ()

@property (nonatomic, strong) HCHomeLayoutServiceImpl *serviceImpl;
@property (nonatomic, strong) HCCategoryApiServicesImpl *cateServiceImpl;
@property (nonatomic, strong) HCInspirationApiServiceImpl *inspServiceImpl;
@property (nonatomic, strong) HCProductDetailApiServiceImp *productDetailServiceImpl;
@property (nonatomic, strong) HCMainStyleApiServiceImp *mainStyleApiServiceImpl;

@end

@implementation HCHomeViewModelServiceImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serviceImpl = [HCHomeLayoutServiceImpl new];
        _cateServiceImpl = [HCCategoryApiServicesImpl new];
        _inspServiceImpl = [HCInspirationApiServiceImpl new];
        _productDetailServiceImpl = [HCProductDetailApiServiceImp new];
        _mainStyleApiServiceImpl = [HCMainStyleApiServiceImp new];
    }
    return self;
}

- (id<HCMainStyleApiService>)getMainStyleApiService {
    return self.mainStyleApiServiceImpl;
}

- (id<HCHomeLayoutService>)getHomeLayoutService {
    return self.serviceImpl;
}

- (id<HCCategoryApiServices>)getCategoryApiService {
    return self.cateServiceImpl;
}

- (id<HCInspirationApiService>)getInspApiService {
    return self.inspServiceImpl;
}

- (id<HCProductDetailApiService>)getProductDetailApiService {
    return self.productDetailServiceImpl;
}

- (void)pushViewModel:(id)viewModel {
    //跳转逻辑
    if ([viewModel isKindOfClass:HCWebViewModel.class]) {
        HCWebViewController *webViewController = [[HCWebViewController alloc] initWithViewModel:viewModel];
        [[GlobalContext ShareInstance].rootController pushViewController:webViewController animated:YES];
    }
    else if ([viewModel isKindOfClass:ProductDetailViewModel.class]) {
        ProductDetailViewController *viewController = [[ProductDetailViewController alloc]initWithViewModel:viewModel];
        [[GlobalContext ShareInstance].rootController pushViewController:viewController animated:YES];
    }
    else if ([viewModel isKindOfClass:HCTabBarViewModel.class]) {
        [[GlobalContext ShareInstance].rootController pushViewController:[GlobalContext ShareInstance].mainTabBarController animated:YES];
    }
}

@end
