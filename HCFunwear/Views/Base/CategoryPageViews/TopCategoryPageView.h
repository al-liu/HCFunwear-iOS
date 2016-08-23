//
//  TopCategoryPageView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCCategory.h"
#import "CategoryPageViewModel.h"
#import "HCViewModelBindProtocol.h"

@interface TopCategoryPageView : UIView <UITableViewDataSource,UITableViewDelegate,HCViewModelBindProtocol>
#warning 这里还有 子标题。。

@property (nonatomic, strong) CategoryPageViewModel *cateViewModel;
@property (nonatomic, strong) NSArray *categoryArray;

- (void)beginRefresh;

@end

