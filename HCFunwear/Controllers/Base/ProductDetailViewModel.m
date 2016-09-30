//
//  ProductDetailViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ProductDetailViewModel.h"
#import "NSObject+YYModel.h"
#import "GlobalConstant.h"

@interface ProductDetailViewModel ()

@property (strong, nonatomic) id <HCHomeViewModelServices> services;

@end

@implementation ProductDetailViewModel

- (instancetype)initWithServices:(id<HCHomeViewModelServices>)services
                     productCode:(NSString *)code {
    self = [super init];
    if (self) {
        _services = services;
        _productCode = code;
        _commentListIndex = 0;
        _commentList = [[NSMutableArray alloc]init];
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.detailRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeDetailSignal];
    }];
    self.commentRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeCommentSignal];
    }];
    self.qaRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeQASignal];
    }];
    self.pushCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executePushSignal:input];
    }];
}

- (RACSignal *)executeDetailSignal {
    return [[[self.services getProductDetailApiService] getProductDetailsWithCode:_productCode] map:^id(id value) {
        self.productDetailModel = [HCProductDetailModel modelWithJSON:value[@"data"]];
        return self.productDetailModel;
    }];
}

- (RACSignal *)executeCommentSignal {
    return [[[self.services getProductDetailApiService] getCommentListWithCode:_productCode page:_commentListIndex] map:^id(id value) {
        NSArray *data = [NSArray modelArrayWithClass:HCCommentListModel.class json:value[@"data"]];
        //处理下模型数据的单元格标识
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HCCommentListModel *model = obj;
            if (model.img_list.count == 0) {
                if (model.subs.count == 0){
                    model.cellIdentifier = kAppraiseOnlyTextNoReplyCellIdentifier;//不带图片 无回复
                }
                else {
                    model.cellIdentifier = kAppraiseOnlyTextCellIdentifier;//不带图片 有回复
                }
            }
            else {
                if (model.subs.count == 0){
                    model.cellIdentifier = kAppraiseNoReplyCellIdentifier;//带图片 无回复
                }
                else {
                    model.cellIdentifier = kAppraiseCellIdentifier;//带图片 有回复
                }
            }
        }];
        NSMutableArray *mutableData = [NSMutableArray arrayWithArray:_commentList];
        [mutableData addObjectsFromArray:data];//为了KVO的监听
        self.commentList = mutableData;
        return self.commentList;
    }];
}

- (RACSignal *)executeQASignal {
    return [[[self.services getProductDetailApiService] getProductConsultListWithCode:_productCode] map:^id(id value) {
        self.qaList = [NSArray modelArrayWithClass:HCProductQAModel.class json:value[@"data"][@"sys"]];
        return self.qaList;
    }];
}

- (RACSignal *)executePushSignal:(id)viewModel {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.services pushViewModel:viewModel];
        [subscriber sendCompleted];
        return nil;
    }];
}

@end
