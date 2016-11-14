//
//  ProductDetailViewModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCHomeViewModelServices.h"
#import "ReactiveCocoa.h"
#import "HCProductDetailModel.h"
#import "HCCommentListModel.h"
#import "HCProductQAModel.h"
#import "HCProductDetailViewModelService.h"
#import "HCBaseViewModel.h"

@interface ProductDetailViewModel : HCBaseViewModel

@property (nonatomic, strong, readonly) RACCommand *detailRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *commentRequestCommand;
@property (nonatomic, strong, readonly) RACCommand *qaRequestCommand;

@property (nonatomic, strong, readonly) RACCommand *pushCommand;
@property (nonatomic, strong, readonly) RACCommand *addGoodsCommand;

@property (nonatomic, strong, readonly) RACSignal *batchStream;

@property (nonatomic, copy, readonly) NSString *productCode;
@property (nonatomic, assign, readonly) NSInteger commentListIndex;
@property (nonatomic, strong, readonly) NSMutableArray *commentList;
@property (nonatomic, strong, readonly) NSArray *qaList;
@property (nonatomic, strong, readonly) HCProductDetailModel *productDetailModel;

- (instancetype)initWithServices:(id<HCProductDetailViewModelService>)service
                     productCode:(NSString *)code;

@end
