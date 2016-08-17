//
//  GlobalConstant.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - cells`Identifier constant
UIKIT_EXTERN NSString *const kProductShowPriceCellIdentifier;
UIKIT_EXTERN NSString *const kProductShowNameCellIdentifier;
UIKIT_EXTERN NSString *const kSingleImageCellIdentifier;
UIKIT_EXTERN NSString *const kLimitTimeBuyCellIdentifier;
UIKIT_EXTERN NSString *const kProductShowStyleCellIdentifier;
UIKIT_EXTERN NSString *const kBrandBorderCellIdentifier;
UIKIT_EXTERN NSString *const kProductShowBrandPriceCellIdentifier;
UIKIT_EXTERN NSString *const kHotBrandViewCellIdentifier;
UIKIT_EXTERN NSString *const kHotCategoryPageViewCellIdentifier;
UIKIT_EXTERN NSString *const kCategoryTableViewCellIdentifier;
UIKIT_EXTERN NSString *const kInspirationInfoCellIdentifier;
UIKIT_EXTERN NSString *const kInspirationAttentionCellIdentifier;

#define defaultImage01 [UIImage imageNamed:@"fan_default_01"]
#define defaultImage02 [UIImage imageNamed:@"fan_default_02"]
#define defaultImage03 [UIImage imageNamed:@"fan_default_03"]
#define defaultImage04 [UIImage imageNamed:@"fan_default_04"]

#pragma mark - Screen Size defines
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define kNavigationBarHeight 64
#define kTabBaHeight 49

@interface GlobalConstant : NSObject

@end
