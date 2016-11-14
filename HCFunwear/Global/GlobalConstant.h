//
//  GlobalConstant.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///
#pragma mark - cells`Identifier constant
UIKIT_EXTERN NSString *const kProductShowPriceCellIdentifier;
UIKIT_EXTERN NSString *const kProductShowNameCellIdentifier;
UIKIT_EXTERN NSString *const kSingleImageCellIdentifier;
UIKIT_EXTERN NSString *const kBrandsViewCellIdentifier;
UIKIT_EXTERN NSString *const kLimitTimeBuyCellIdentifier;
UIKIT_EXTERN NSString *const kProductShowStyleCellIdentifier;
UIKIT_EXTERN NSString *const kBrandBorderCellIdentifier;
UIKIT_EXTERN NSString *const kProductShowBrandPriceCellIdentifier;
UIKIT_EXTERN NSString *const kHotBrandViewCellIdentifier;
UIKIT_EXTERN NSString *const kHotCategoryPageViewCellIdentifier;
UIKIT_EXTERN NSString *const kCategoryTableViewCellIdentifier;
UIKIT_EXTERN NSString *const kInspirationInfoCellIdentifier;
UIKIT_EXTERN NSString *const kInspirationAttentionCellIdentifier;
UIKIT_EXTERN NSString *const kHCGoodsDetailShopPlanCellIdentifier;

UIKIT_EXTERN NSString *const kAppraiseCellIdentifier;
UIKIT_EXTERN NSString *const kAppraiseOnlyTextCellIdentifier;
UIKIT_EXTERN NSString *const kAppraiseNoReplyCellIdentifier;
UIKIT_EXTERN NSString *const kAppraiseOnlyTextNoReplyCellIdentifier;

///
#pragma mark - UserDefault key constant
UIKIT_EXTERN NSString *const kCID;

#define defaultImage01 [UIImage imageNamed:@"fan_default_01"]
#define defaultImage02 [UIImage imageNamed:@"fan_default_02"]
#define defaultImage03 [UIImage imageNamed:@"fan_default_03"]
#define defaultImage04 [UIImage imageNamed:@"fan_default_04"]

///
#pragma mark - Screen Size defines
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define kNavigationBarHeight 64
#define kTabBaHeight 49

///
#pragma mark - NSError's custom domain and code
UIKIT_EXTERN NSString *const kFunwearDomain;
typedef NS_ENUM(NSInteger,FunwearErrorCode) {
    FunwearLogicErrorCode = -100
};

///
#pragma mark - common block define
///------
/// Block
///------

typedef void (^VoidBlock)();
typedef BOOL (^BoolBlock)();
typedef int  (^IntBlock) ();
typedef id   (^IDBlock)  ();

typedef void (^VoidBlock_int)(int);
typedef BOOL (^BoolBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IDBlock_int)  (int);

typedef void (^VoidBlock_string)(NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef id   (^IDBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef BOOL (^BoolBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IDBlock_id)  (id);

@interface GlobalConstant : NSObject

@end
