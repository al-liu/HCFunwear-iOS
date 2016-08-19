//
//  GlobalContext.h
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCTabBarController.h"
#import "HCWindow.h"

@interface GlobalContext : NSObject

@property (nonatomic, strong) HCWindow *applicationWindow;
@property (nonatomic, strong) HCTabBarController *mainTabBarController;

+ (instancetype)ShareInstance;

@end
