//
//  CategoryPageViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "CategoryPageViewModel.h"
#import "CategroyLayoutApi.h"
#import "NSObject+YYModel.h"
#import "GetCategoryListApi.h"
#import "HCCategory.h"
#import "HCBrand.h"
#import "HCCategoryApiServices.h"

@interface CategoryPageViewModel ()

@property (strong, nonatomic, readonly) id <HCCategoryViewModelServices> services;

@property (nonatomic, strong, readwrite) RACCommand *layoutRequestCommand;
@property (nonatomic, strong, readwrite) RACCommand *categorysRequestCommand;
@property (nonatomic, strong, readwrite) RACCommand *brandsRequestCommand;
@property (nonatomic, strong, readwrite) RACCommand *pushCommand;

@property (nonatomic, strong, readwrite) HCCategoryLayout *hotLayout;
@property (nonatomic, strong, readwrite) NSArray *cateList;
@property (nonatomic, strong, readwrite) NSMutableArray *brandList;

@property (nonatomic, strong, readwrite) NSArray *topTitlesList;

@end

@implementation CategoryPageViewModel
@dynamic services;

- (void)initialize {
    
    _cateList = [NSArray array];
    _brandList = [NSMutableArray array];
    _topTitlesList = @[@"热门",@"品类",@"品牌"];
    _brandsPageIndex = 0;
    _refreshHotFlag = YES;
    _refreshCategoryFlag = YES;
    _refreshBrandFlag = YES;
    
    self.layoutRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeHotSignal];
    }];
    self.categorysRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeCateSignal];
    }];
    self.brandsRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeBrandSignal:(NSInteger)input];
    }];
    self.pushCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executePushSignal:input];
    }];
}

- (RACSignal *)executeHotSignal {
    @weakify(self);
    return [[[self.services getCategoryApiService] getHotTapData] map:^id(id value) {
        @strongify(self);
        self.hotLayout = [HCCategoryLayout modelWithJSON:value[@"data"]];
        return self.hotLayout;
    }];
}

- (RACSignal *)executeCateSignal {
    return [[[self.services getCategoryApiService] getCateTapData] map:^id(id value) {
        self.cateList = [NSArray modelArrayWithClass:HCCategory.class json:value[@"data"]];
        return self.cateList;
    }];
}

- (RACSignal *)executeBrandSignal:(NSInteger)pageIndex {
    return [[[self.services getCategoryApiService] getBrandDataWithIndexPage:_brandsPageIndex] map:^id(id value) {
        NSArray *data = [NSArray modelArrayWithClass:HCBrand.class json:value[@"data"]];
        NSMutableArray *mutableData = [NSMutableArray arrayWithArray:_brandList];
        [mutableData addObjectsFromArray:data];//为了KVO的监听
        self.brandList = mutableData;
        return self.brandList;
    }];
}

- (RACSignal *)executePushSignal:(id)viewModel {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.services pushViewModel:viewModel animated:YES];
        [subscriber sendCompleted];
        return nil;
    }];
}

@end
