//
//  HCCounterView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/11/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCCounterView : UIView

@property (nonatomic, assign, readonly) NSInteger countValue;

@property (nonatomic, assign) NSInteger minCount;

@property (nonatomic, assign) NSInteger maxCount;

- (void)resetCount:(NSInteger)count;

@end
