//
//  TopHotPageView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCCategoryLayout.h"
#import "CategoryPageViewModel.h"
#import "HCViewModelBindProtocol.h"
#import "HCWebViewModel.h"

@interface TopHotPageView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,HCViewModelBindProtocol>

@property (nonatomic, strong) CategoryPageViewModel *cateViewModel;
@property (nonatomic, strong) HCCategoryLayout *cateMoudule;

- (void)beginRefresh;

@end
