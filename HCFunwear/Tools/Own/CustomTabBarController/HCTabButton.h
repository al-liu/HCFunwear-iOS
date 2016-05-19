//
//  HCTabButton.h
//  HCmafengwo
//
//  Created by 刘海川 on 16/4/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTabItem.h"

typedef NS_ENUM(NSInteger, HCTabButtonStyle) {
    HCTabButtonStyleVertical,
    HCTabButtonStyleHorizontal
};

@interface HCTabButton : UIButton

@property (nonatomic, assign, readonly) HCTabButtonStyle tabButtonStyle;

- (instancetype)initWithItem:(HCTabItem *)item style:(HCTabButtonStyle)style;
- (instancetype)initWithItem:(HCTabItem *)item;
- (void)updateItem:(HCTabItem *)item;

@end
