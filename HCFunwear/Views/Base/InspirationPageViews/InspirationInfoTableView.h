//
//  InspirationInfoTableView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/9.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InspirationInfoTableView;
@protocol InspirationInfoTableDelegate <NSObject>

- (void)inspirationInfoTableView:(InspirationInfoTableView *)infoView PageForIndex:(NSInteger)indx;

@end
@interface InspirationInfoTableView : UIView <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) id <InspirationInfoTableDelegate> delegate;

@end
