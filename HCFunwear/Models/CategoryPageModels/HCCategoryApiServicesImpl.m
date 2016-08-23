//
//  HCCategoryApiServicesImpl.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/23.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCCategoryApiServicesImpl.h"
#import "ReactiveCocoa.h"
#import "CategroyLayoutApi.h"
#import "GetCategoryListApi.h"
#import "GetAppBrandListApi.h"

@implementation HCCategoryApiServicesImpl

- (RACSignal *)getHotTapData {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        CategroyLayoutApi *api = [[CategroyLayoutApi alloc]init];
        id cacheResponseObject = [api cacheJson];
        if (cacheResponseObject) {
            [subscriber sendNext:cacheResponseObject];
        }
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            [subscriber sendNext:request.responseJSONObject];
            [subscriber sendCompleted];
        } failure:^(__kindof YTKBaseRequest *request) {
            [subscriber sendError:request.requestOperationError];
        }];
        return nil;
    }];
}

- (RACSignal *)getCateTapData {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        GetCategoryListApi *api = [[GetCategoryListApi alloc]init];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            [subscriber sendNext:request.responseJSONObject];
            [subscriber sendCompleted];
        } failure:^(__kindof YTKBaseRequest *request) {
            [subscriber sendError:request.requestOperationError];
        }];
        return nil;
    }];
}

- (RACSignal *)getBrandDataWithIndexPage:(NSInteger)indexPage {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        GetAppBrandListApi *api = [[GetAppBrandListApi alloc]initWithPageIndex:indexPage];
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
