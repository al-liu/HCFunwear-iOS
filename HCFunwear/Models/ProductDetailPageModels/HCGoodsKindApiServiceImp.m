//
//  HCGoodsKindApiServiceImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsKindApiServiceImp.h"
#import "ProductFilterApi.h"

@implementation HCGoodsKindApiServiceImp

- (RACSignal *)productFilterWithCode:(NSString *)code {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        ProductFilterApi *api = [[ProductFilterApi alloc]initWithCode:code];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            [subscriber sendNext:request.responseJSONObject];
            [subscriber sendCompleted];
        } failure:^(__kindof YTKBaseRequest *request) {
            [subscriber sendError:request.requestOperationError];
        }];
        return nil;
    }];
}

@end
