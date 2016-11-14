//
//  HCMainStyleViewModelService.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCProductDetailApiService.h"
#import "HCMainStyleApiService.h"
#import "HCNavigationService.h"
#import "HCBaseService.h"

@protocol HCMainStyleViewModelService <HCBaseService>

- (id<HCMainStyleApiService>)getMainStyleApiService;

- (RACSignal *)selectedStyle:(NSInteger)tag;

@end
