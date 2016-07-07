//
//  TopCategoryView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopCategoryView;
@protocol TopCategoryViewDelegate <NSObject>

- (NSString *)topCategoryView:(TopCategoryView *)topCategoryView labelForTitleAtIndex:(NSInteger)index;

- (void)topCategoryView:(TopCategoryView *)topCategoryView clickAtIndex:(NSInteger)index;

@end
@interface TopCategoryView : UIView

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) id <TopCategoryViewDelegate> delegate;

@end
