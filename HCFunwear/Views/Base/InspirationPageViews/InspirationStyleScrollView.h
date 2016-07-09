//
//  InspirationStyleScrollView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/9.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InspirationStyleScrollView;
@protocol InspirationStyleScrollDelegate <NSObject>

- (void)inspirationStyleScrollView:(InspirationStyleScrollView *)infoView PageForIndex:(NSInteger)indx;

@end
@interface InspirationStyleScrollView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) id <InspirationStyleScrollDelegate> delegate;

@end
