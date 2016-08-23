//
//  TopBrandPageView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryPageViewModel.h"
#import "HCViewModelBindProtocol.h"

@interface TopBrandPageView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,HCViewModelBindProtocol>

@property (nonatomic, strong) CategoryPageViewModel *cateViewModel;

@property (nonatomic, strong) NSArray *brandsList;

- (void)beginRefresh;

@end
