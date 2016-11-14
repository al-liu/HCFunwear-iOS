//
//  HCNavigationControllerStack.m
//  HCFunwear
//
//  Created by 刘海川 on 16/11/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCNavigationControllerStack.h"

@interface HCNavigationControllerStack ()

@property (nonatomic, copy) NSDictionary *viewModelViewMappings;

@property (nonatomic, strong) NSMutableArray *navigationControllers;

@end

@implementation HCNavigationControllerStack

+ (instancetype)sharedInstance {
    static HCNavigationControllerStack *stack = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [self new];
    });
    return stack;
}

/// router setting
- (HCBaseViewController *)viewControllerFromRouterWithViewModel:(HCBaseViewModel *)viewModel {
    NSString *viewControllerStr = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    NSParameterAssert([NSClassFromString(viewControllerStr) isSubclassOfClass:[HCBaseViewController class]]);
    NSParameterAssert([NSClassFromString(viewControllerStr) instancesRespondToSelector:@selector(initWithViewModel:)]);
    return [[NSClassFromString(viewControllerStr) alloc] initWithViewModel:viewModel];
}

- (NSDictionary *)viewModelViewMappings {
    if (!_viewModelViewMappings) {
        _viewModelViewMappings = @{
                                   @"MainStyleViewModel":@"MainStyleViewController",
                                   @"HomePageViewModel":@"HomePageViewController",
                                   @"CategoryPageViewModel":@"CategoryPageViewController",
                                   @"InspirationPageViewModel":@"InspirationPageViewController",
                                   @"ShoppingBagPageViewModel":@"ShoppingBagPageViewController",
                                   @"MinePageViewModel":@"MinePageViewController",
                                   @"HCWebViewModel":@"HCWebViewController",
                                   @"ProductDetailViewModel":@"ProductDetailViewController",
                                   @"HCProductDetailStyleViewModel":@"HCProductDetailStyleViewController"
                                   };
    }
    
    return _viewModelViewMappings;
}

- (NSMutableArray *)navigationControllers {
    if (!_navigationControllers) {
        _navigationControllers = [NSMutableArray array];
    }
    return _navigationControllers;
}

///
- (void)pushNavigationController:(UINavigationController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) return;
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    UINavigationController *navigationController = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController {
    return self.navigationControllers.lastObject;
}

@end
