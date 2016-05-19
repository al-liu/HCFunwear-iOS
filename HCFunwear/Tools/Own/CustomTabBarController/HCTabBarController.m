//
//  HCTabBarController.m
//  HCmafengwo
//
//  Created by 刘海川 on 16/4/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCTabBarController.h"
#import "HCTabBar.h"

@implementation HCTabBarController

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
    [self layoutViewControllers];
    
    return self;
}

- (void)layoutViewControllers {
    
    for (int i = 0; i < _viewControllers.count; i++) {
        UIViewController *viewController = _viewControllers[i];
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        [self.view addSubview:viewController.view];
        [self didMoveToParentViewController:viewController];
    }
    [self selectedViewControllerAtIndex:0];
}

- (void)setTabBar:(HCTabBar *)tabBar {
    _tabBar = tabBar;
    _tabBar.tabBarDelegate = self;
    [self.view addSubview:_tabBar];
}

- (void)selectedViewControllerAtIndex:(NSInteger)index {
    for (int i = 0; i < _viewControllers.count; i++) {
        UIViewController *viewController = _viewControllers[i];
        if (index == i) {
            viewController.view.hidden = NO;
        }
        else {
            viewController.view.hidden = YES;
        }
    }
}

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
