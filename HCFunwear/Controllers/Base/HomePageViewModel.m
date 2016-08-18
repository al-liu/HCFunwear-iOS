//
//  HomePageViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HomePageViewModel.h"
#import "HCGridMenuView.h"
#import "HomePageHeadTitleView.h"
#import "HomeLayoutApi.h"
#import "HCModule.h"
#import "NSObject+YYModel.h"
#import "GetRecommedProductListApi.h"
#import "HCProduct.h"
#import "RACEXTScope.h"

@implementation HomePageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBind];
        _topStyleTitleArray = @[@"男生",@"女生",@"生活"];
        _productsPage = 0;
    }
    return self;
}

//临时数据

- (void)initBind {
    _layoutRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
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
        
        return [requestSignal map:^id(NSDictionary *value) {
            NSMutableArray *modules = value[@"data"][@"module"];
            NSArray *homeModuleList = [NSArray modelArrayWithClass:HCModule.class json:modules];
            return homeModuleList;
        }];
    }];
    
#warning issue:_productsRequestCommand
    //这里有问题
    @weakify(self);
    _productsRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            GetRecommedProductListApi *api = [[GetRecommedProductListApi alloc]initWithPage:self.productsPage];
            [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
                [subscriber sendNext:request.responseJSONObject];
                [subscriber sendCompleted];
            } failure:^(__kindof YTKBaseRequest *request) {
                [subscriber sendError:request.requestOperationError];
            }];
            return nil;
        }];
        
        return [requestSignal map:^id(NSDictionary *value) {
            NSArray *productList = value[@"data"][@"productList"];
            NSArray *productModelList = [NSArray modelArrayWithClass:HCProduct.class json:productList];
            return productModelList;
        }];
    }];
}

#pragma mark - 交易
// 可能要讲交易组合起来

@end
