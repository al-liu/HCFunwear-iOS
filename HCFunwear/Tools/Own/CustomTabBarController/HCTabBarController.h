//
//  HCTabBarController.h
//  HCmafengwo
//
//  Created by 刘海川 on 16/4/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTabBar.h"

@class HCTabBarController;
@protocol HCTabBarControllerDelegate <NSObject>

- (void)tabBarController:(HCTabBarController *)tabBarController indexOfSelectedViewController:(NSInteger)index;

@optional
- (void)tabBarController:(HCTabBarController *)tabBarController indexOfRepeatSelectedViewController:(NSInteger)index;

//- (void)tabBarControllerWillLayoutViewControllers:(HCTabBarController *)tabBarController;
//- (void)tabBarControllerDidLayoutViewControllers:(HCTabBarController *)tabBarController;

@end
@interface HCTabBarController : UIViewController <tabBarDelegate>

@property (nonatomic, weak) id <HCTabBarControllerDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray *viewControllers;
@property (nonatomic, strong) HCTabBar *tabBar;

- (instancetype)initWithViewControllers:(NSArray *)controllers;
- (void)selectedViewControllerAtIndex:(NSInteger)index;

@end
