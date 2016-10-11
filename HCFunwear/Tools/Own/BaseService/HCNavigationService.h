//
//  HCNavigationService.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^voidBlock)(void);


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
- (void)pushViewModel:(id)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;

- (void)presentViewModel:(id)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

- (void)resetRootViewModel:(id)viewModel;


@end
