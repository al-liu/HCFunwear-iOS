//
//  HCSelectedMoudleView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCSelectedMoudleView;
@protocol HCSelectedMoudleDelegate <NSObject>

- (void)selectedMoudleView:(HCSelectedMoudleView *)moudleView
             selectedIndex:(NSUInteger)index;

@end

@interface HCSelectedMoudleView : UIView

@property (nonatomic,weak) id <HCSelectedMoudleDelegate> delegate;
@property (nonatomic,copy) void(^selectedMoudleBlock)(NSUInteger);

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles;

- (void)selectedWithIndex:(NSUInteger)index;

- (void)setAppraiseTitle:(NSString *)title;

@end
