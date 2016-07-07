//
//  HCTabBarController.m
//  HCmafengwo
//
//  Created by 刘海川 on 16/4/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCTabBarController.h"
#import "HCTabBar.h"

@implementation HCTabBarController {
    NSInteger currentIndex;
}

#pragma mark - Life cycle
- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)controllers {
    self = [super init];
    if (!self) return nil;
    
    _viewControllers = controllers;
    [self selectedViewControllerAtIndex:currentIndex = 0];
    
    return self;
}

- (void)setTabBar:(HCTabBar *)tabBar {
    _tabBar = tabBar;
    _tabBar.tabBarDelegate = self;
    [self.view addSubview:_tabBar];
}

- (void)displayViewControllerWithIndex:(NSInteger)index {
    UIViewController *viewController = _viewControllers[index];
    [self addChildViewController:viewController];
    viewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    if (self.tabBar) {
        [self.view insertSubview:viewController.view belowSubview:self.tabBar];
    }
    else {
        [self.view addSubview:viewController.view];
    }
    [self didMoveToParentViewController:viewController];
}

- (void)hideViewControllerWithIndex:(NSInteger)index {
    UIViewController *viewController = _viewControllers[index];
    if (viewController.parentViewController) {
        [viewController willMoveToParentViewController:nil];
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }
}

- (void)selectedViewControllerAtIndex:(NSInteger)index {
    [self hideViewControllerWithIndex:currentIndex];
    [self displayViewControllerWithIndex:index];
    currentIndex = index;}

#pragma mark - tabBarDelegate
- (void)indexOfSelectedTab:(NSInteger)tabIndex {
    if (tabIndex < _viewControllers.count) {
        [self selectedViewControllerAtIndex:tabIndex];
        if (_delegate && [_delegate respondsToSelector:@selector(tabBarController: indexOfSelectedViewController:)]) {
            [_delegate tabBarController:self indexOfSelectedViewController:tabIndex];
        }
    }
}

- (void)indexOfRepeatSelectedTab:(NSInteger)tabIndex {
    if (tabIndex < _viewControllers.count) {
        if (_delegate && [_delegate respondsToSelector:@selector(tabBarController: indexOfRepeatSelectedViewController:)]) {
            [_delegate tabBarController:self indexOfRepeatSelectedViewController:tabIndex];
        }
    }
}

@end
