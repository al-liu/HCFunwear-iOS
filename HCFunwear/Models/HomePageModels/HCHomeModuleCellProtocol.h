//
//  HCHomeModuleCellProtocol.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@protocol HCHomeModuleCellProtocol <NSObject>

- (void)bindData:(id)data;
/**
 *  push 传递的事件
 *
 *  @param push execute:viewModel
 */
- (void)bindPush:(RACCommand *)push;

@end
