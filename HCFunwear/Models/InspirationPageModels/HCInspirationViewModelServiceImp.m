//
//  HCInspirationViewModelServiceImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCInspirationViewModelServiceImp.h"
#import "HCInspirationApiServiceImpl.h"

#import "HCWebViewModel.h"
#import "ProductDetailViewModel.h"
#import "HCTabBarViewModel.h"

#import "HCWebViewController.h"
#import "GlobalContext.h"
#import "ProductDetailViewController.h"

@interface HCInspirationViewModelServiceImp ()

@property (nonatomic, strong) HCInspirationApiServiceImpl *inspServiceImpl;

@end

@implementation HCInspirationViewModelServiceImp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _inspServiceImpl = [HCInspirationApiServiceImpl new];
    }
    return self;
}

- (id<HCInspirationApiService>)getInspApiService {
    return self.inspServiceImpl;
}

- (void)pushViewModel:(__nullable id)viewModel animated:(BOOL)animated {
    //跳转逻辑
    [super pushViewModel:viewModel animated:animated];
}


@end
