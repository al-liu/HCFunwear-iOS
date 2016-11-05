//
//  HCGoodsKindModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class HCGoodsKindSizeModel;
@interface HCGoodsKindModel : NSObject

@property (nonatomic, copy) NSString *proD_CLS_NUM;
@property (nonatomic, copy) NSString *lM_PROD_CLS_ID;
@property (nonatomic, copy) NSString *barcode_sys_code;
@property (nonatomic, copy) NSString *branD_ID;
@property (nonatomic, copy) NSString *brand_name;
@property (nonatomic, copy) NSString *proD_NUM;
@property (nonatomic, copy) NSString *proD_NAME;
@property (nonatomic, copy) NSString *coloR_ID;
@property (nonatomic, copy) NSString *coloR_NAME;
@property (nonatomic, copy) NSString *coloR_FILE_PATH;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *salE_PRICE;
@property (nonatomic, copy) NSString *salE_QTY;
@property (nonatomic, copy) NSString *activity_id;
@property (nonatomic, copy) NSString *activity_icon;
@property (nonatomic, copy) NSString *activity_rule;
@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray <HCGoodsKindSizeModel *> *sizeList;

@property (nonatomic, assign) CGFloat color_tag_width;

@end

@interface HCGoodsKindSizeModel : NSObject

//尺寸
@property (nonatomic, copy) NSString *speC_ID;
@property (nonatomic, copy) NSString *speC_NAME;
@property (nonatomic, assign) CGFloat spec_tag_width;
//库存
@property (nonatomic, copy) NSString *lisT_QTY;

@end
