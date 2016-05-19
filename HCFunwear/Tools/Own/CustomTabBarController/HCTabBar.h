//
//  HCTabBar.h
//  HCmafengwo
//
//  Created by 刘海川 on 16/4/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tabBarDelegate <NSObject>

- (void)indexOfSelectedTab:(NSInteger)tabIndex;

@optional
- (void)indexOfRepeatSelectedTab:(NSInteger)tabIndex;

@end

@interface HCTabBar : UIView

@property (nonatomic, strong, readonly) NSArray *tabButtonList;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;
@property (nonatomic, weak) id <tabBarDelegate> tabBarDelegate;

- (instancetype)initWithTabViews:(NSArray *)tabbuttons;

- (void)reloadTab:(NSArray *)tabButtons;
- (void)selectTabAtindex:(NSInteger)index;

@end
