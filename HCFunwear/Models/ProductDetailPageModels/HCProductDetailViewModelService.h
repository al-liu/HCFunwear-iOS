//
//  HCProductDetailViewModelService.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCNavigationService.h"
#import "HCProductDetailApiService.h"
#import "HCBaseService.h"

@protocol HCProductDetailViewModelService <HCBaseService>

- (id<HCProductDetailApiService>)getProductDetailApiService;

@end
