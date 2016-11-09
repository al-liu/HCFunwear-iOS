//
//  HCProductDetailStyleViewModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCGoodsKindViewModelService.h"

@interface HCProductDetailStyleViewModel : NSObject

@property (nonatomic, strong) RACCommand *requestCommand;

@property (nonatomic, strong) RACCommand *pushCommand;

@property (nonatomic, strong) RACCommand *dismissCommand;

@property (nonatomic, strong) RACCommand *affirmCommand;

@property (nonatomic, copy) NSString *goodsCode;

@property (nonatomic, strong) NSArray *goodsKindList;

- (instancetype)initWithServices:(id<HCGoodsKindViewModelService>)services;

@end
