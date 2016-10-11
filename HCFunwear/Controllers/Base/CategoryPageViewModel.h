//
//  CategoryPageViewModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "GetAppBrandListApi.h"
#import "HCCategoryApiServices.h"
#import "HCCategoryViewModelServices.h"
#import "HCCategoryLayout.h"

@interface CategoryPageViewModel : NSObject

@property (nonatomic, strong) RACCommand *layoutRequestCommand;
@property (nonatomic, strong) RACCommand *categorysRequestCommand;
@property (nonatomic, strong) RACCommand *brandsRequestCommand;
@property (nonatomic, strong) RACCommand *pushCommand;

@property (nonatomic, strong) HCCategoryLayout *hotLayout;
@property (nonatomic, strong) NSArray *cateList;
@property (nonatomic, strong) NSMutableArray *brandList;

@property (nonatomic, strong) NSArray *topTitlesList;
@property (nonatomic, assign) NSInteger brandsPageIndex;

//yes 是需要刷新
@property (nonatomic, assign) BOOL refreshHotFlag;
@property (nonatomic, assign) BOOL refreshCategoryFlag;
@property (nonatomic, assign) BOOL refreshBrandFlag;

- (instancetype)initWithServices:(id<HCCategoryViewModelServices>)services;

@end
