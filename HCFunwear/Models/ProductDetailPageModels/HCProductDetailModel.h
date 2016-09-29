//
//  HCProductDetailModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HCClsInfo,HCBrandDispatchGoods;
@interface HCProductDetailModel : NSObject

@property (nonatomic, strong) HCClsInfo *clsInfo;
@property (nonatomic, assign) BOOL isFavorite;
@property (nonatomic, strong) NSArray *proPicUrl;
@property (nonatomic, strong) NSArray *clsPicUrl;
@property (nonatomic, strong) NSArray *activity;
@property (nonatomic, strong) NSArray *addPicUrl;
@property (nonatomic, strong) HCBrandDispatchGoods *brandDispatchGoods;
@property (nonatomic, strong) NSArray *sizeTable;
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *avgComment;
@property (nonatomic, copy) NSString *isCanUseVoucher;
@property (nonatomic, copy) NSString *voucherTip;

@end

@interface HCClsInfo : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *sale_price;
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *brandId;
@property (nonatomic, copy) NSString *brandUrl;
@property (nonatomic, copy) NSString *showName;
@property (nonatomic, copy) NSString *stockCount;
@property (nonatomic, copy) NSString *statusname;
@property (nonatomic, copy) NSString *mainImage;
@property (nonatomic, copy) NSString *clsDescription;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *collocationShoppingIcon;
@property (nonatomic, copy) NSString *collocationShoppingEndTime;
@property (nonatomic, copy) NSString *isNoSale;
@property (nonatomic, copy) NSString *isWish;
@property (nonatomic, copy) NSString *normalActivityIcon;
@property (nonatomic, copy) NSString *normalActivityCutdown;

@end

@interface HCPicUrl : NSObject

@property (nonatomic, strong) NSURL *filE_PATH;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *isMainImage;

@end

@interface HCActivity : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon_content;
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *type;

@end

@interface HCAddPicUrl : NSObject

@property (nonatomic, strong) NSURL *image_url;
@property (nonatomic, copy) NSString *type;

@end

@interface HCBrandDispatchGoods : NSObject

@property (nonatomic, strong) NSURL *img;
@property (nonatomic, strong) NSURL *url;

@end
