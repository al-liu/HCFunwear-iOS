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

@interface TopHotPageView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) CategoryPageViewModel *cateViewModel;
@property (nonatomic, strong) HCCategoryLayout *cateMoudule;

- (void)reload;
- (void)beginRefresh;

@end
