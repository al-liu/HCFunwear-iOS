//
//  HCHudManager.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/1.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HCHudManager : NSObject

@property (nonatomic, strong) MBProgressHUD *activityHUD;

@property (nonatomic, assign) NSInteger *activityCount;

- (void)addHUDToView:(UIView*)view;
- (void)show;
- (void)hidden;
- (void)close;

@end
