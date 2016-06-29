//
//  GlobalContext.h
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCTabBarController.h"

@interface GlobalContext : NSObject

@property (nonatomic, strong) HCTabBarController *mainTabBarController;

+ (instancetype)ShareInstance;

@end
