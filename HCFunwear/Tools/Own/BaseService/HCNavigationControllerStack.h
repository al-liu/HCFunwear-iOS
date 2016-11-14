//
//  HCNavigationControllerStack.h
//  HCFunwear
//
//  Created by 刘海川 on 16/11/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HCBaseViewController.h"

@interface HCNavigationControllerStack : NSObject

+ (instancetype)sharedInstance;

//this is a router
- (HCBaseViewController *)viewControllerFromRouterWithViewModel:(HCBaseViewModel *)vieModel;

//manage NavigationController Stack
//管理整个程序有多少层次的导航控制器
/*
    比如
    RootNavigationController --- Window.rootController->Navigation->TabBarController
            |
    HomePageNavigationController --- TabBarController.frist->Navigation->HomePageController
            |
    LoginNavigationController --- HomePageNavigationController->present->LoginNavigation
            |
    ...
 
 */
- (void)pushNavigationController:(UINavigationController *)navigationController;

- (UINavigationController *)popNavigationController;

- (UINavigationController *)topNavigationController;

@end
