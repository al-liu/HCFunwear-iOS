//
//  InspirationStyleScrollView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/9.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCInspirationInfos.h"
#import "HCViewModelBindProtocol.h"

@class InspirationStyleScrollView;
@protocol InspirationStyleScrollDelegate <NSObject>

- (void)inspirationStyleScrollView:(InspirationStyleScrollView *)infoView
                         pageIndex:(NSInteger)indx
                           tabInfo:(HCInfoTab *)tab;

@end
@interface InspirationStyleScrollView : UIView <UIScrollViewDelegate,HCViewModelBindProtocol>

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) id <InspirationStyleScrollDelegate> delegate;

- (instancetype)initWithDatas:(NSArray *)tabsList;

- (void)reloadWithTabs:(NSArray *)tabs;
- (void)scrollTabWithIndex:(NSInteger)index;

@end
