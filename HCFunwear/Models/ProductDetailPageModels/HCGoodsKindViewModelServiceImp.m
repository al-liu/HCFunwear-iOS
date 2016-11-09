//
//  HCGoodsKindViewModelServiceImp.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsKindViewModelServiceImp.h"
#import "HCGoodsKindApiService.h"
#import "HCGoodsKindApiServiceImp.h"

#import "HCProductDetailStyleViewController.h"
#import "GlobalContext.h"

#import "HCShoppingCartGoodsModel.h"
#import "FMDB.h"

@interface HCGoodsKindViewModelServiceImp ()

@property (nonatomic, strong) id<HCGoodsKindApiService> goodsKindApiService;

@end

@implementation HCGoodsKindViewModelServiceImp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _goodsKindApiService = [HCGoodsKindApiServiceImp new];
    }
    return self;
}

- (id<HCGoodsKindApiService>)getGoodsKindApiService {
    return _goodsKindApiService;
}

- (void)presentViewModel:(__nullable id)viewModel animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    if ([viewModel isKindOfClass:HCProductDetailStyleViewModel.class]) {
        HCProductDetailStyleViewController *viewController = [[HCProductDetailStyleViewController alloc] initWithViewModel:viewModel];
        [[GlobalContext ShareInstance].rootController pushViewController:viewController animated:YES];
    }
}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [[GlobalContext ShareInstance].rootController dismissViewControllerAnimated:animated completion:nil];
}
/*
 #define proD_CLS_NUM_key  @"proD_CLS_NUM"
 #define branD_ID_key  @"branD_ID";
 #define brand_name_key  @"brand_name";
 #define proD_NUM_key  @"proD_NUM";
 #define proD_NAME_key  @"proD_NAME";
 #define coloR_ID_key  @"coloR_ID";
 #define coloR_NAME_key  @"coloR_NAME";
 #define coloR_FILE_PATH_key  @"coloR_FILE_PATH";
 #define salE_PRICE_key  @"salE_PRICE";
 #define speC_ID_key  @"speC_ID";
 #define speC_NAME_key  @"speC_NAME";
 #define count_key  @"count";
 */
- (void)addGoods:(id)goods {
    if ([goods isKindOfClass:HCShoppingCartGoodsModel.class]) {
        HCShoppingCartGoodsModel *goodsModel = goods;
        NSString *db_path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:dbName];
        NSLog(@"db path :%@",db_path);
        FMDatabase *database = [FMDatabase databaseWithPath:db_path];
        if ([database open]) {
            //table statement
            NSString *table_statement = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER)",
                     cart_goods_table_name,
                     proD_CLS_NUM_key,branD_ID_key,brand_name_key,
                     proD_NUM_key,proD_NAME_key,coloR_ID_key,
                     coloR_NAME_key,coloR_FILE_PATH_key,salE_PRICE_key,
                     speC_ID_key,speC_NAME_key,count_key];
            [database executeUpdate:table_statement];
            
            //insert
            NSString *insert_statement = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %ld)",
                                          cart_goods_table_name,
                                          proD_CLS_NUM_key,branD_ID_key,brand_name_key,
                                          proD_NUM_key,proD_NAME_key,coloR_ID_key,
                                          coloR_NAME_key,coloR_FILE_PATH_key,salE_PRICE_key,
                                          speC_ID_key,speC_NAME_key,count_key,
                                          goodsModel.proD_CLS_NUM,goodsModel.branD_ID,goodsModel.brand_name,
                                          goodsModel.proD_NUM,goodsModel.proD_NAME,goodsModel.coloR_ID,
                                          goodsModel.coloR_NAME,goodsModel.coloR_FILE_PATH,goodsModel.salE_PRICE,
                                          goodsModel.speC_ID,goodsModel.speC_NAME,goodsModel.count ];
            [database executeUpdate:insert_statement];
                        
            [database close];
            
            [self dismissViewModelAnimated:YES completion:nil];
        }
    }
}

@end
