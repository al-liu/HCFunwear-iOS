//
//  HCProductDetailApiServiceImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailApiServiceImp.h"
#import "GetProductDetailsApi.h"
#import "GetCommentListApi.h"
#import "GetProductConsultListApi.h"

@implementation HCProductDetailApiServiceImp

- (RACSignal *)getProductDetailsWithCode:(NSString *)code {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        GetProductDetailsApi *api = [[GetProductDetailsApi alloc]initWithCode:code];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            [subscriber sendNext:request.responseJSONObject];
            [subscriber sendCompleted];
        } failure:^(__kindof YTKBaseRequest *request) {
            [subscriber sendError:request.requestOperationError];
        }];
        return nil;
    }];
}
- (RACSignal *)getCommentListWithCode:(NSString *)code page:(NSInteger)page {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        GetCommentListApi *api = [[GetCommentListApi alloc]initWithCode:code page:page];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            [subscriber sendNext:request.responseJSONObject];
            [subscriber sendCompleted];
        } failure:^(__kindof YTKBaseRequest *request) {
            [subscriber sendError:request.requestOperationError];
        }];
        return nil;
    }];
}
- (RACSignal *)getProductConsultListWithCode:(NSString *)code {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        GetProductConsultListApi *api = [[GetProductConsultListApi alloc]initWithCode:code];
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
