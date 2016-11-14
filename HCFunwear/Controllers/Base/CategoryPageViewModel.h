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
#import "HCBaseViewModel.h"

@interface CategoryPageViewModel : HCBaseViewModel

@property (nonatomic, strong, readonly) RACCommand *layoutRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *categorysRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *brandsRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *pushCommand;

@property (nonatomic, strong, readonly) HCCategoryLayout *hotLayout;
@property (nonatomic, strong, readonly) NSArray *cateList;
@property (nonatomic, strong, readonly) NSMutableArray *brandList;

@property (nonatomic, strong, readonly) NSArray *topTitlesList;
@property (nonatomic, assign) NSInteger brandsPageIndex;

//yes 是需要刷新
@property (nonatomic, assign) BOOL refreshHotFlag;
@property (nonatomic, assign) BOOL refreshCategoryFlag;
@property (nonatomic, assign) BOOL refreshBrandFlag;

@end
