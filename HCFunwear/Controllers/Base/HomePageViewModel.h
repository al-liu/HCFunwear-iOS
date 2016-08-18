//
//  HomePageViewModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface HomePageViewModel : NSObject

@property (nonatomic, strong) RACCommand *layoutRequestCommand;
@property (nonatomic, strong) RACCommand *productsRequestCommand;
@property (nonatomic, assign) NSInteger productsPage;

@property (nonatomic, strong) NSArray *topStyleTitleArray;

@end
