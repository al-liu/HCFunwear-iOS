//
//  InspirationPageViewModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCInspirationViewModelService.h"
#import "HCInspirationInfos.h"
#import "HCBaseViewModel.h"

@interface InspirationPageViewModel : HCBaseViewModel

@property (nonatomic, strong, readonly) RACCommand *infosRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *funerRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *pushCommand;

@property (nonatomic, strong, readonly) NSArray *topTitlesList;

@property (nonatomic, assign) NSInteger infoPageIndex;
@property (nonatomic, assign) NSInteger infoPageSize;
@property (nonatomic, copy) NSString *infoAid;

@property (nonatomic, assign) NSInteger funerPageIndex;

@property (nonatomic, strong) HCInspirationInfos *inspInfos;
@property (nonatomic, strong) NSArray *inspFunerList;

@end
