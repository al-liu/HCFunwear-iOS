//
//  HCGoodsKindViewModelService.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCNavigationService.h"
#import "HCGoodsKindApiService.h"

@protocol HCGoodsKindViewModelService <HCNavigationService>

- (id<HCGoodsKindApiService>)getGoodsKindApiService;

- (void)addGoods:(id)goods;

@end
