//
//  HCHomeLayoutServiceImpl.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCHomeLayoutServiceImpl.h"
#import "HomeLayoutApi.h"
#import "NSObject+YYModel.h"
#import "GetRecommedProductListApi.h"

@implementation HCHomeLayoutServiceImpl

- (RACSignal *)getLayoutModule {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        HomeLayoutApi *api = [[HomeLayoutApi alloc]init];
        id cacheResponseObject = [api cacheJson];
        if (cacheResponseObject) {
            [subscriber sendNext:cacheResponseObject];
            [subscriber sendCompleted];
        }
        else {
            [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
                [subscriber sendNext:request.responseJSONObject];
                [subscriber sendCompleted];
            } failure:^(__kindof YTKBaseRequest *request) {
                [subscriber sendError:request.requestOperationError];
            }];
        }
        return nil;
    }];
}

- (RACSignal *)getProductsWithIndexPage:(NSInteger)indexPage {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        GetRecommedProductListApi *api = [[GetRecommedProductListApi alloc]initWithPage:indexPage];
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
