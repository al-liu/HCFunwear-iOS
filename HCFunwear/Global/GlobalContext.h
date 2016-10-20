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
@property (nonatomic, strong) UINavigationController *rootController;

// cid 1,2,3 = man，woman，life 风格
@property (nonatomic, copy) NSString *cid;
// MainStyle 里展示广告 每次进 app 才有
@property (nonatomic, assign) BOOL isShowAdvert;

+ (instancetype)ShareInstance;

@end
