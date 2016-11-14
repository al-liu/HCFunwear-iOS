//
//  BaseViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/11/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCBaseViewModel.h"

@interface HCBaseViewModel ()

@property (nonatomic, strong, readwrite) id<HCBaseService> services;

@end

@implementation HCBaseViewModel

- (instancetype)initWithServices:(id<HCBaseService>)services {
    self = [super init];
    if (self) {
        self.services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize {};

@end
