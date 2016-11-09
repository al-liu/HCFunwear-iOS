//
//  HCShoppingCartGoodsModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/11/6.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

//表和键
#define dbName @"hcfunwear.db"
#define cart_goods_table_name  @"HCShoppingCartGoodsModel"
#define proD_CLS_NUM_key  @"proD_CLS_NUM"
#define branD_ID_key  @"branD_ID"
#define brand_name_key  @"brand_name"
#define proD_NUM_key  @"proD_NUM"
#define proD_NAME_key  @"proD_NAME"
#define coloR_ID_key  @"coloR_ID"
#define coloR_NAME_key  @"coloR_NAME"
#define coloR_FILE_PATH_key  @"coloR_FILE_PATH"
#define salE_PRICE_key  @"salE_PRICE"
#define speC_ID_key  @"speC_ID"
#define speC_NAME_key  @"speC_NAME"
#define count_key  @"count"

@interface HCShoppingCartGoodsModel : NSObject
//ID
@property (nonatomic, copy) NSString *proD_CLS_NUM;
//品牌
@property (nonatomic, copy) NSString *branD_ID;
@property (nonatomic, copy) NSString *brand_name;
//产品名
@property (nonatomic, copy) NSString *proD_NUM;
@property (nonatomic, copy) NSString *proD_NAME;
//颜色
@property (nonatomic, copy) NSString *coloR_ID;
@property (nonatomic, copy) NSString *coloR_NAME;
@property (nonatomic, copy) NSString *coloR_FILE_PATH;
//价格
@property (nonatomic, copy) NSString *salE_PRICE;
//尺寸
@property (nonatomic, copy) NSString *speC_ID;
@property (nonatomic, copy) NSString *speC_NAME;
//数量
@property (nonatomic, assign) NSInteger count;

@end
