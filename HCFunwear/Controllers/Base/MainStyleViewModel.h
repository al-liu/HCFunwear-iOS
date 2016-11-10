//
//  MainStyleViewModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCMainStyleViewModelService.h"
#import "AppConfigModel.h"

@interface MainStyleViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *appConfigRequestCommand;

@property (nonatomic, strong, readonly) RACCommand *pushCommand;

@property (nonatomic, strong, readonly) RACCommand *tapCommand;

@property (nonatomic, strong, readonly) AppConfigModel *appConfigModel;

@property (nonatomic, strong, readonly) UIImage *launchBannerImage;

- (instancetype)initWithServices:(id<HCMainStyleViewModelService>)services;

@end
