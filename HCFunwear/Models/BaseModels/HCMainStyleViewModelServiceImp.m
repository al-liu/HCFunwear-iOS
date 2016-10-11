//
//  HCMainStyleViewModelServiceImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCMainStyleViewModelServiceImp.h"
#import "HCMainStyleApiServiceImp.h"
#import "GlobalContext.h"
#import "HCTabBarViewModel.h"

@interface HCMainStyleViewModelServiceImp ()

@property (nonatomic, strong) HCMainStyleApiServiceImp *mainStyleApiServiceImpl;

@end

@implementation HCMainStyleViewModelServiceImp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mainStyleApiServiceImpl = [HCMainStyleApiServiceImp new];
        
    }
    return self;
}

- (id<HCMainStyleApiService>)getMainStyleApiService {
    return self.mainStyleApiServiceImpl;
}

- (void)pushViewModel:(__nullable id)viewModel animated:(BOOL)animated {
    //跳转逻辑
    if ([viewModel isKindOfClass:HCTabBarViewModel.class]) {
        [[GlobalContext ShareInstance].rootController pushViewController:[GlobalContext ShareInstance].mainTabBarController animated:YES];
    }
}

@end
