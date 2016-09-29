//
//  HCProductDetailApiService.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@protocol HCProductDetailApiService <NSObject>

- (RACSignal *)getProductDetailsWithCode:(NSString *)code;
- (RACSignal *)getCommentListWithCode:(NSString *)code page:(NSInteger)page;
- (RACSignal *)getProductConsultListWithCode:(NSString *)code;

@end
