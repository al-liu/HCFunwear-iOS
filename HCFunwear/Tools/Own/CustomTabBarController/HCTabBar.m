//
//  HCTabBar.m
//  HCmafengwo
//
//  Created by 刘海川 on 16/4/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCTabBar.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kTabBarWidth [[UIScreen mainScreen] bounds].size.width
#define kTabBarHeight 49

@implementation HCTabBar

- (instancetype)initWithTabViews:(NSArray *)tabbuttons {
    self = [super initWithFrame:CGRectMake(0, kScreenHeight-kTabBarHeight, kTabBarWidth, kTabBarHeight)];
    if (!self) return nil;
    self.backgroundColor = [UIColor whiteColor];
    _selectedIndex = -1;
    [self reloadTab:tabbuttons];
    
    //顶部线
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTabBarWidth, .5f)];
    topLine.backgroundColor = [UIColor colorWithWhite:0.757 alpha:1.000];
    [self addSubview:topLine];
    
    return self;
}

- (void)reloadTab:(NSArray *)tabButtons {
    _tabButtonList = tabButtons;
    //布局标签
    if (self.subviews.count > 0) {
        [self.subviews performSelector:@selector(removeFromSuperview)];
    }
    
    CGFloat tabWidth = kTabBarWidth / _tabButtonList.count;
    
    for (int i = 0; i < _tabButtonList.count; i++) {
        UIButton *tabbutton = _tabButtonList[i];
        tabbutton.frame = CGRectMake(tabWidth * i, 0, tabWidth, kTabBarHeight);
        tabbutton.tag = i;
        [tabbutton addTarget:self action:@selector(tabButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tabbutton];
    }
    [self selectTabAtindex:0];
}

- (void)selectTabAtindex:(NSInteger)index {
    if (index == _selectedIndex) {
        if (_tabBarDelegate && [_tabBarDelegate respondsToSelector:@selector(indexOfRepeatSelectedTab:)]) {
            [_tabBarDelegate indexOfRepeatSelectedTab:index];
        }
        return;
    }
    _selectedIndex = index;
    for (int i = 0; i < _tabButtonList.count; i++) {
        UIButton *tabbutton = _tabButtonList[i];
        if (i == index) {
            [tabbutton setSelected:YES];
        }
        else {
            [tabbutton setSelected:NO];
        }
    }
    
    if (_tabBarDelegate && [_tabBarDelegate respondsToSelector:@selector(indexOfSelectedTab:)]) {
        [_tabBarDelegate indexOfSelectedTab:index];
    }
}

- (void)tabButtonAction:(UIButton *)tabbutton {
    [self selectTabAtindex:tabbutton.tag];
}

@end
