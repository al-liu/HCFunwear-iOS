//
//  BaseViewModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/11/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCBaseService.h"

@interface HCBaseViewModel : NSObject

@property (nonatomic, strong, readonly) id<HCBaseService> services;

- (instancetype)initWithServices:(id<HCBaseService>)services;

@end
