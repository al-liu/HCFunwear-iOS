//
//  HCInspirationApiServiceImpl.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCInspirationApiServiceImpl.h"
#import "ReactiveCocoa.h"
#import "HCGetSpecialListForInspApi.h"
#import "HCGetCollocationListByUserTypeApi.h"

@implementation HCInspirationApiServiceImpl

- (RACSignal *)getInspInfoDataWithIndexPage:(NSInteger)indexPage
                                   pageSize:(NSInteger)pageSize
                                     typeId:(NSString *)aid {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        HCGetSpecialListForInspApi *api = [[HCGetSpecialListForInspApi alloc]initWithPageIndex:indexPage
                                                                                          size:pageSize
                                                                                        typeId:aid];
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

- (RACSignal *)getInspInfoFunerDataWithIndexPage:(NSInteger)indexPage {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        HCGetCollocationListByUserTypeApi *api = [[HCGetCollocationListByUserTypeApi alloc]initWithPageIndex:indexPage];
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

@end
