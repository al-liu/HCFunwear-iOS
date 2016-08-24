//
//  InspirationPageViewModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCHomeViewModelServices.h"
#import "HCInspirationInfos.h"

@interface InspirationPageViewModel : NSObject

@property (nonatomic, strong) RACCommand *infosRequestCommand;
@property (nonatomic, strong) RACCommand *funerRequestCommand;
@property (nonatomic, strong) RACCommand *pushCommand;
@property (nonatomic, strong) NSArray *topTitlesList;

@property (nonatomic, assign) NSInteger infoPageIndex;
@property (nonatomic, assign) NSInteger infoPageSize;
@property (nonatomic, copy) NSString *infoAid;

@property (nonatomic, assign) NSInteger funerPageIndex;

@property (nonatomic, strong) HCInspirationInfos *inspInfos;


- (instancetype)initWithServices:(id<HCHomeViewModelServices>)services;

@end
