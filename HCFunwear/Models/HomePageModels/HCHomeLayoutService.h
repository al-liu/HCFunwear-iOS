//
//  HCHomeLayoutService.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"


/**
 api 服务
 */
@protocol HCHomeLayoutService <NSObject>

- (RACSignal *)getLayoutModule;
- (RACSignal *)getProductsWithIndexPage:(NSInteger)indexPage;

@end
