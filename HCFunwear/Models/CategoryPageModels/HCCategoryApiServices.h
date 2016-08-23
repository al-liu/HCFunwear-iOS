//
//  HCCategoryApiServices.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/23.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@protocol HCCategoryApiServices <NSObject>

- (RACSignal *)getHotTapData;
- (RACSignal *)getCateTapData;
- (RACSignal *)getBrandDataWithIndexPage:(NSInteger)indexPage;

@end
