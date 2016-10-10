//
//  HCMainStyleApiServiceImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCMainStyleApiServiceImp.h"
#import "GetAppConfigApi.h"

@implementation HCMainStyleApiServiceImp

- (RACSignal *)getAppConfig {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        GetAppConfigApi *api = [[GetAppConfigApi alloc]init];
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
