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
#import "HCSliderLeftPresentAnimator.h"
#import "HCSliderLeftDismissAnimator.h"

@interface HCHomeViewModelServiceImpl () <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) HCSliderLeftPresentAnimator *animator;

@property (nonatomic, strong) HCHomeLayoutServiceImpl *serviceImpl;

@end

@implementation HCHomeViewModelServiceImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serviceImpl = [HCHomeLayoutServiceImpl new];
        
        _animator = [HCSliderLeftPresentAnimator new];
        _animator.gobackSliderLeftBlock = ^(){
            [[HCNavigationControllerStack sharedInstance].topNavigationController dismissViewControllerAnimated:YES
                                                                                                     completion:nil];
        };
    }
    return self;
}

- (id<HCHomeLayoutService>)getHomeLayoutService {
    return self.serviceImpl;
}

- (void)pushViewModel:(__nullable id)viewModel animated:(BOOL)animated {
    //跳转逻辑
    [super pushViewModel:viewModel animated:animated];
}

- (void)presentViewModel:(id)viewModel animated:(BOOL)animated completion:(void (^)(void))completion {
    HCBaseViewController *viewController = [[HCNavigationControllerStack sharedInstance] viewControllerFromRouterWithViewModel:viewModel];
    if ([viewController isKindOfClass:[HCSliderLeftViewController class]]) {
        HCSliderLeftViewController *toViewController = (HCSliderLeftViewController *)viewController;
        toViewController.transitioningDelegate = self;
        toViewController.modalPresentationStyle = UIModalPresentationCustom;
        [[HCNavigationControllerStack sharedInstance].topNavigationController presentViewController:toViewController
                                                                                           animated:YES
                                                                                         completion:nil];
    }
}

- (RACSignal *)selectedStyle:(NSInteger)tag {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *changedCid ;
        if (tag == 0) {
            changedCid = @"1";
        }
        else if (tag == 1) {
            changedCid = @"2";
        }
        else if (tag == 2) {
            changedCid = @"4";
        }
        else {
            NSDictionary *userinfo = @{NSLocalizedDescriptionKey:@"#FunwearLogicErrorCode# selected the Cid is invaild"};
            NSError *error = [NSError errorWithDomain:kFunwearDomain
                                                 code:FunwearLogicErrorCode
                                             userInfo:userinfo];
            [subscriber sendError:error];
        }
        
        if (![changedCid isEqualToString:[GlobalContext ShareInstance].cid]) {
            RACTuple *tuple = [RACTuple tupleWithObjects:changedCid,@YES,nil];
            [subscriber sendNext:tuple];
        }
        
        [subscriber sendCompleted];
        
        return nil;
    }];
}

#pragma mark - 定制转场动画 (Present 与 Dismiss动画代理)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    return _animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    HCSliderLeftDismissAnimator *dismissAnimator   = [HCSliderLeftDismissAnimator new];
    // 退出控制器动画
    return dismissAnimator;
}

@end
