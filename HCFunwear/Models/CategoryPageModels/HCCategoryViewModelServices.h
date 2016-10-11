//
//  HCCategoryViewModelServices.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCNavigationService.h"
#import "HCCategoryApiServices.h"

@protocol HCCategoryViewModelServices <HCNavigationService>

- (id<HCCategoryApiServices>)getCategoryApiService;

@end
