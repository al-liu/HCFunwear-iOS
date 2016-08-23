//
//  HCViewModelBindProtocol.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  较通用的绑定协议
 */
@protocol HCViewModelBindProtocol <NSObject>
@optional
/**
 *  view 引用到 ViewModel 就可以将 VM 里的一些数据绑定到视图上
 *  可以使用 VM 里的一些信号 如：网络，跳转等。
 *
 *  @param viewModel 有关于 View 的状态量
 */
- (void)bindViewModel:(id)viewModel;

/**
 *  数据呈现
 *
 *  @param data 一些模型
 */
- (void)bindData:(id)data;

/**
 *  单独绑定的跳转信号
 *
 *  @param push VM 中的跳转信号
 */
- (void)bindPush:(RACCommand *)push;

@end
