//
//  HCNavigationService.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 导航服务 供 ViewModel 的总线服务实现
 */
@protocol HCNavigationService <NSObject>
@optional

/**
 UINavigationController 的 push 跳转

 @param viewModel 对应页面的 ViewModel 根据 ViewModel 找到要跳转的页面
 @param animated  是否有跳转动画
 */
- (void)pushViewModel:(__nullable id)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;

- (void)presentViewModel:(__nullable id)viewModel animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

- (void)resetRootViewModel:(__nullable id)viewModel;


@end
