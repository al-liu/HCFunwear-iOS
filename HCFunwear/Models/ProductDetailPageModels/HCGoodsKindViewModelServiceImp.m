//
//  HCGoodsKindViewModelServiceImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsKindViewModelServiceImp.h"
#import "HCGoodsKindApiService.h"
#import "HCGoodsKindApiServiceImp.h"

#import "HCProductDetailStyleViewController.h"
#import "GlobalContext.h"

@interface HCGoodsKindViewModelServiceImp ()

@property (nonatomic, strong) id<HCGoodsKindApiService> goodsKindApiService;

@end

@implementation HCGoodsKindViewModelServiceImp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _goodsKindApiService = [HCGoodsKindApiServiceImp new];
    }
    return self;
}

- (id<HCGoodsKindApiService>)getGoodsKindApiService {
    return _goodsKindApiService;
}

- (void)presentViewModel:(__nullable id)viewModel animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    if ([viewModel isKindOfClass:HCProductDetailStyleViewModel.class]) {
        HCProductDetailStyleViewController *viewController = [[HCProductDetailStyleViewController alloc] initWithViewModel:viewModel];
        [[GlobalContext ShareInstance].rootController pushViewController:viewController animated:YES];
    }
}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [[GlobalContext ShareInstance].rootController dismissViewControllerAnimated:animated completion:nil];
}

@end
