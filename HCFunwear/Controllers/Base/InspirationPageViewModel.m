//
//  InspirationPageViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "InspirationPageViewModel.h"
#import "NSObject+YYModel.h"
#import "HCInspirationByUsers.h"

@interface InspirationPageViewModel ()

@property (strong, nonatomic, readonly) id <HCInspirationViewModelService> services;

@property (nonatomic, strong, readwrite) RACCommand *infosRequestCommand;
@property (nonatomic, strong, readwrite) RACCommand *funerRequestCommand;
@property (nonatomic, strong, readwrite) RACCommand *pushCommand;

@property (nonatomic, strong, readwrite) NSArray *topTitlesList;

@end

@implementation InspirationPageViewModel
@dynamic services;

- (void)initialize {
    
    _topTitlesList = @[@"资讯",@"范儿",@"关注"];
    _infoPageIndex = 1;
    _infoPageSize = 10;
    _infoAid = @"";
    _funerPageIndex = 0;
    
    self.infosRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeInfosSignal];
    }];
    self.funerRequestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeFunerSignal];
    }];
    self.pushCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executePushSignal:input];
    }];
}

- (RACSignal *)executeInfosSignal {
    return [[[self.services getInspApiService] getInspInfoDataWithIndexPage:self.infoPageIndex
                                                                  pageSize:self.infoPageSize
                                                                    typeId:self.infoAid] map:^id(id value) {
        HCInspirationInfos *info = [HCInspirationInfos modelWithJSON:value[@"data"]];
        self.inspInfos = info;
        return info;
    }];
}

- (RACSignal *)executeFunerSignal {
    return [[[self.services getInspApiService] getInspInfoFunerDataWithIndexPage:self.funerPageIndex] map:^id(id value) {
        self.inspFunerList = [NSArray modelArrayWithClass:HCInspirationByUsers.class json:value[@"data"]];
        return self.inspFunerList;
    }];
}

- (RACSignal *)executePushSignal:(id)viewModel {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.services pushViewModel:viewModel animated:YES];
        [subscriber sendCompleted];
        return nil;
    }];
}

@end
