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

@interface CategoryPageViewModel : NSObject

@property (nonatomic, strong) RACCommand *layoutRequestCommand;
@property (nonatomic, strong) RACCommand *categorysRequestCommand;
@property (nonatomic, strong) RACCommand *brandsRequestCommand;

@property (nonatomic, strong) GetAppBrandListApi *brandApi;

@end
