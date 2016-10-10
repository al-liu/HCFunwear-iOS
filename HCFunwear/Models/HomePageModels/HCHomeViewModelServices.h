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

@protocol HCHomeViewModelServices <NSObject>

- (void)pushViewModel:(id)viewModel;

- (id<HCHomeLayoutService>)getHomeLayoutService;

- (id<HCCategoryApiServices>)getCategoryApiService;

- (id<HCInspirationApiService>)getInspApiService;

- (id<HCProductDetailApiService>)getProductDetailApiService;

- (id<HCMainStyleApiService>)getMainStyleApiService;

@end
