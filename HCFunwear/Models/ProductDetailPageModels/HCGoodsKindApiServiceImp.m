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

/*
 
 [1]	(null)	@"NSErrorFailingURLKey" : @"http://api.funwear.com/mbfun_server/index.php?_platform=1&deviceId=41A19C47-0EAB-45AC-98C1-28E852EE5F17&appName=youfanguanfang&osName=iPhone%20OS&osCode=ios&osVersion=9.2.1&a=ProductFilter&cid=2&m=ProductFilter&prodClsIdList=818936&token="
 
 */

@end
