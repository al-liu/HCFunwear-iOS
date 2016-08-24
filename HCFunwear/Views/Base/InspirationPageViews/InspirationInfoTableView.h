//
//  InspirationInfoTableView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/9.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCViewModelBindProtocol.h"

@class InspirationInfoTableView;
@protocol InspirationInfoTableDelegate <NSObject>

- (void)inspirationInfoTableView:(InspirationInfoTableView *)infoView pageForIndex:(NSInteger)indx;

@end
@interface InspirationInfoTableView : UIView <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,HCViewModelBindProtocol>

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) id <InspirationInfoTableDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *tableArray;
- (instancetype)initWithDatas:(NSArray *)tabsList;

- (void)header_beginRefreshing;

- (void)reloadWithTabs:(NSArray *)tabs;
- (void)scrollTabWithIndex:(NSInteger)index;

@end
