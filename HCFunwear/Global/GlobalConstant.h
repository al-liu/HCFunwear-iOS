//
//  GlobalConstant.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - cells`Identifier constant
extern NSString *const kProductShowPriceCellIdentifier;
extern NSString *const kProductShowNameCellIdentifier;
extern NSString *const kSingleImageCellIdentifier;
extern NSString *const kLimitTimeBuyCellIdentifier;
extern NSString *const kProductShowStyleCellIdentifier;
extern NSString *const kBrandBorderCellIdentifier;
extern NSString *const kProductShowBrandPriceCellIdentifier;
extern NSString *const kHotBrandViewCellIdentifier;
extern NSString *const kHotCategoryPageViewCellIdentifier;
extern NSString *const kCategoryTableViewCellIdentifier;
extern NSString *const kInspirationInfoCellIdentifier;
extern NSString *const kInspirationAttentionCellIdentifier;

#pragma mark - Screen Size defines
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define kNavigationBarHeight 64
#define kTabBaHeight 49

@interface GlobalConstant : NSObject

@end
