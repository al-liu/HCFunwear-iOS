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

@interface ProductDetailViewModel : NSObject

@property (nonatomic, strong) RACCommand *detailRequestCommand;
@property (nonatomic, strong) RACCommand *commentRequestCommand;
@property (nonatomic, strong) RACCommand *qaRequestCommand;
@property (nonatomic, strong) RACCommand *pushCommand;

@property (nonatomic, strong) RACSignal *batchStream;

@property (nonatomic, copy) NSString *productCode;
@property (nonatomic, assign) NSInteger commentListIndex;
@property (nonatomic, strong) NSMutableArray *commentList;
@property (nonatomic, strong) NSArray *qaList;
@property (nonatomic, strong) HCProductDetailModel *productDetailModel;

- (instancetype)initWithServices:(id<HCProductDetailViewModelService>)services
                     productCode:(NSString *)code;

@end
