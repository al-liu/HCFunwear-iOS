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

@property (nonatomic, strong) RACCommand *appConfigRequestCommand;

@property (nonatomic, strong) RACCommand *pushCommand;

@property (nonatomic, strong) AppConfigModel *appConfigModel;

@property (nonatomic, strong) UIImage *launchBannerImage;

- (instancetype)initWithServices:(id<HCMainStyleViewModelService>)services;

@end
