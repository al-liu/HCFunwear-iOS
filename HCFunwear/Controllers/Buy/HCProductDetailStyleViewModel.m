//
//  HCProductDetailStyleViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailStyleViewModel.h"
#import "HCGoodsKindModel.h"

static CGFloat TAG_HEIGHT = 24;
@interface HCProductDetailStyleViewModel ()

@property (nonatomic, strong) id <HCGoodsKindViewModelService> services;

@end

@implementation HCProductDetailStyleViewModel

- (instancetype)initWithServices:(id<HCGoodsKindViewModelService>)services {
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeGoodsKindSignal];
    }];
    
    self.pushCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executePushSignal:input];
    }];
    
    self.dismissCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executeDismissSignal];
    }];
}

- (RACSignal *)executeGoodsKindSignal {
    return [[[_services getGoodsKindApiService] productFilterWithCode:_goodsCode] map:^id(id value) {
        NSArray *datas = value[@"results"];
        self.goodsKindList = [self handleApiData:datas];
        return self.goodsKindList;
    }];
}

- (RACSignal *)executePushSignal:(id)viewModel {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.services pushViewModel:viewModel animated:YES];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (RACSignal *)executeDismissSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.services dismissViewModelAnimated:YES completion:nil];
        [subscriber sendCompleted];
        return nil;
    }];
}
//处理数据，得到适合视图显示的数据结构。
- (NSArray *)handleApiData:(NSArray *)datas {
    NSMutableArray *processDataArray = [NSMutableArray array];
    
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *data = obj;
        
        HCGoodsKindModel *goodsKindModel = processDataArray.lastObject;
        if (goodsKindModel && [goodsKindModel.coloR_ID isEqualToString:data[@"coloR_ID"]]) {
            //将这一种样式商品的 一种 size 类型加进去。
            HCGoodsKindSizeModel *goodsKindSizeModel = [HCGoodsKindSizeModel new];
            goodsKindSizeModel.speC_ID = data[@"speC_ID"];
            goodsKindSizeModel.speC_NAME = data[@"speC_NAME"];
            goodsKindSizeModel.spec_tag_width = [self getTagWidthWithText:data[@"speC_NAME"]];
            goodsKindSizeModel.lisT_QTY = [data[@"lisT_QTY"] description];
            
            NSMutableArray *mutableSizeList = [[NSMutableArray alloc]initWithArray:goodsKindModel.sizeList];
            [mutableSizeList addObject:goodsKindSizeModel];
            goodsKindModel.sizeList = [mutableSizeList copy];
        }
        else {
            //创建新样式的商品信息
            goodsKindModel = [HCGoodsKindModel new];
            //样式基础信息
            goodsKindModel.proD_CLS_NUM = data[@"proD_CLS_NUM"];
            goodsKindModel.lM_PROD_CLS_ID = data[@"lM_PROD_CLS_ID"];
            goodsKindModel.barcode_sys_code = data[@"barcode_sys_code"];
            goodsKindModel.branD_ID = data[@"branD_ID"];
            goodsKindModel.brand_name = data[@"brand_name"];
            goodsKindModel.proD_NUM = data[@"proD_NUM"];
            goodsKindModel.proD_NAME = data[@"proD_NAME"];
            goodsKindModel.coloR_ID = data[@"coloR_ID"];
            goodsKindModel.coloR_NAME = data[@"coloR_NAME"];
            goodsKindModel.coloR_FILE_PATH = data[@"coloR_FILE_PATH"];
            goodsKindModel.price = [data[@"price"] description];
            goodsKindModel.salE_PRICE = [data[@"salE_PRICE"] description];
            goodsKindModel.salE_QTY = [data[@"salE_QTY"] description];
            goodsKindModel.activity_id = [data[@"activity_id"] description];
            goodsKindModel.activity_icon = data[@"activity_icon"];
            goodsKindModel.activity_rule = data[@"activity_rule"];
            goodsKindModel.status = [data[@"status"] description];
            goodsKindModel.color_tag_width = [self getTagWidthWithText:data[@"coloR_NAME"]];
            
            HCGoodsKindSizeModel *goodsKindSizeModel = [HCGoodsKindSizeModel new];
            goodsKindSizeModel.speC_ID = data[@"speC_ID"];
            goodsKindSizeModel.speC_NAME = data[@"speC_NAME"];
            goodsKindSizeModel.spec_tag_width = [self getTagWidthWithText:data[@"speC_NAME"]];
            goodsKindSizeModel.lisT_QTY = [data[@"lisT_QTY"] description];
            
            NSMutableArray *mutableSizeList = [[NSMutableArray alloc]initWithArray:goodsKindModel.sizeList];
            [mutableSizeList addObject:goodsKindSizeModel];
            goodsKindModel.sizeList = [mutableSizeList copy];
            
            [processDataArray addObject:goodsKindModel];
        }
    }];
    return processDataArray;
}

/*
    默认使用 24 的高度
    默认使用 13 的字号
    默认增加 10 的偏差量
 
 */
- (CGFloat)getTagWidthWithText:(NSString *)tagString {
    
    CGRect tagRect = [tagString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, TAG_HEIGHT)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                             context:nil];
    CGFloat countItemWidth = tagRect.size.width + 10;
    return countItemWidth;
}

@end
