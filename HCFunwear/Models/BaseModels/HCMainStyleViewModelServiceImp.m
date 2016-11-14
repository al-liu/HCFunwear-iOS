//
//  HCMainStyleViewModelServiceImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCMainStyleViewModelServiceImp.h"
#import "HCMainStyleApiServiceImp.h"
#import "GlobalContext.h"
#import "GlobalConstant.h"
#import "HCTabBarViewModel.h"

#import "CategoryPageViewController.h"
#import "HomePageViewController.h"

@interface HCMainStyleViewModelServiceImp () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) HCMainStyleApiServiceImp *mainStyleApiServiceImpl;

@end

@implementation HCMainStyleViewModelServiceImp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mainStyleApiServiceImpl = [HCMainStyleApiServiceImp new];
        
    }
    return self;
}

- (id<HCMainStyleApiService>)getMainStyleApiService {
    return self.mainStyleApiServiceImpl;
}

- (void)pushViewModel:(__nullable id)viewModel animated:(BOOL)animated {
    //跳转逻辑
    if ([viewModel isKindOfClass:HCTabBarViewModel.class]) {
        [[GlobalContext ShareInstance].rootController pushViewController:[GlobalContext ShareInstance].mainTabBarController animated:YES];
    }
}

- (RACSignal *)selectedStyle:(NSInteger)tag {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *changedCid ;
        if (tag == 1) {
            changedCid = @"1";
        }
        else if (tag == 2) {
            changedCid = @"2";
        }
        else if (tag == 3) {
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
        
        [GlobalContext ShareInstance].rootController.transitioningDelegate = self;
        [GlobalContext ShareInstance].rootController.modalPresentationStyle = UIModalPresentationCustom;
        [[GlobalContext ShareInstance].applicationWindow.rootViewController presentViewController:[GlobalContext ShareInstance].rootController animated:YES completion:nil];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
}

#pragma mark - 定制转场动画 (Present 与 Dismiss动画代理)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    // 推出控制器的动画
    return [HCMainStylePresentAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    HCMainStyleDismissAnimator *dismissAnimator   = [HCMainStyleDismissAnimator new];
    // 退出控制器动画
    return dismissAnimator;
}

@end
