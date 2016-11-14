//
//  HomePageViewModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "HCHomeViewModelServices.h"
#import "HCBaseViewModel.h"

@interface HomePageViewModel : HCBaseViewModel

@property (nonatomic, strong, readonly) RACCommand *layoutRequestCommand;

@property (nonatomic, strong, readonly) RACCommand *productsRequestCommand;

@property (nonatomic, strong, readonly) RACCommand *tapCommand;

@property (nonatomic, strong, readonly) RACCommand *pushCommand;

@property (nonatomic, strong, readonly) RACCommand *toLeftSideCommand;

@property (nonatomic, assign) NSInteger productsPage;

@property (nonatomic, strong, readonly) NSArray *topStyleTitleArray;

@property (nonatomic, strong, readonly) NSArray *layoutDataArray;

@property (nonatomic, strong, readonly) NSArray *productsDataArray;

//yes 是需要刷新
@property (nonatomic, assign) BOOL refreshFlag;

@end
