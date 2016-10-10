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

@interface HomePageViewModel : NSObject

- (instancetype)initWithServices:(id<HCHomeViewModelServices>)services;

@property (nonatomic, strong) RACCommand *layoutRequestCommand;
@property (nonatomic, strong) RACCommand *productsRequestCommand;
@property (nonatomic, strong) RACCommand *pushCommand;

@property (nonatomic, assign) NSInteger productsPage;

@property (nonatomic, strong) NSArray *topStyleTitleArray;

@property (nonatomic, strong) NSArray *layoutDataArray;
@property (nonatomic, strong) NSArray *productsDataArray;

@end
