//
//  CategoryPageViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "CategoryPageViewModel.h"
#import "CategroyLayoutApi.h"
#import "HCCategoryLayout.h"
#import "NSObject+YYModel.h"
#import "GetCategoryListApi.h"
#import "HCCategory.h"
#import "HCBrand.h"

@implementation CategoryPageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.brandApi = [[GetAppBrandListApi alloc]initWithPageIndex:0];
        [self initBind];
    }
    return self;
}

- (void)initBind {
    _layoutRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            CategroyLayoutApi *api = [[CategroyLayoutApi alloc]init];
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
        
        return [requestSignal map:^id(NSDictionary *value) {
            HCCategoryLayout *layout = [HCCategoryLayout modelWithJSON:value[@"data"]];
            return layout;
        }];
    }];
    
    _categorysRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            GetCategoryListApi *api = [[GetCategoryListApi alloc]init];
            [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
                [subscriber sendNext:request.responseJSONObject];
                [subscriber sendCompleted];
            } failure:^(__kindof YTKBaseRequest *request) {
                [subscriber sendError:request.requestOperationError];
            }];
            return nil;
        }];
        
        return [requestSignal map:^id(NSDictionary *value) {
            NSArray *categoryList = [NSArray modelArrayWithClass:HCCategory.class json:value[@"data"]];
            return categoryList;
        }];
    }];
    
    @weakify(self);
    _brandsRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self.brandApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
                [subscriber sendNext:request.responseJSONObject];
                [subscriber sendCompleted];
            } failure:^(__kindof YTKBaseRequest *request) {
                [subscriber sendError:request.requestOperationError];
            }];
            return nil;
        }];
        
        return [requestSignal map:^id(NSDictionary *value) {
            NSArray *brandList = [NSArray modelArrayWithClass:HCBrand.class json:value[@"data"]];
            return brandList;
        }];
    }];
}

@end
