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
#import "HCProductDetailStyleViewModel.h"
#import "HCProductDetailStyleViewController.h"

#import "HCProductDetailStylePresentAnimator.h"
#import "HCProductDetailStylePopAnimator.h"

#import "GlobalContext.h"

@interface HCProductDetailViewModelServiceImp () 

@property (nonatomic, strong) HCProductDetailApiServiceImp *productDetailServiceImpl;

@property (nonatomic, strong) HCProductDetailStylePresentAnimator *productDetailStylePresentAnimator;

@end

@implementation HCProductDetailViewModelServiceImp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _productDetailServiceImpl = [HCProductDetailApiServiceImp new];
        
        _productDetailStylePresentAnimator = [HCProductDetailStylePresentAnimator new];
        
        @weakify(self);
        _productDetailStylePresentAnimator.productStyleBlock = ^(){
            @strongify(self);
            [self dismissViewModelAnimated:YES completion:nil];
        };
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

- (void)presentViewModel:(id)viewModel animated:(BOOL)animated completion:(void (^)(void))completion {
    if ([viewModel isKindOfClass:HCProductDetailStyleViewModel.class]) {
        HCProductDetailStyleViewController *detailStyleViewController = [[HCProductDetailStyleViewController alloc]initWithViewModel:viewModel];
        detailStyleViewController.transitioningDelegate = self;
        detailStyleViewController.modalPresentationStyle = UIModalPresentationCustom;
        [[GlobalContext ShareInstance].rootController presentViewController:detailStyleViewController animated:YES completion:nil];
    }
}

#pragma mark - 定制转场动画 (Present 与 Dismiss动画代理)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    // 推出控制器的动画
    return _productDetailStylePresentAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    HCProductDetailStylePopAnimator *dismissAnimator   = [HCProductDetailStylePopAnimator new];
    return dismissAnimator;
}


@end
