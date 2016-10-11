//  HCHomeViewModelServices.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCHomeLayoutService.h"
#import "HCCategoryApiServices.h"
#import "HCInspirationApiService.h"
#import "HCProductDetailApiService.h"
#import "HCMainStyleApiService.h"
#import "HCNavigationService.h"

/**
 首页的总线服务
 */
@protocol HCHomeViewModelServices <HCNavigationService>

- (id<HCHomeLayoutService>)getHomeLayoutService;

@end
