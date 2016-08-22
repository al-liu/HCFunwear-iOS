//
//  HCGridMenuViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGridMenuViewCell.h"
#import "Masonry.h"
#import "HCModule.h"
#import "HCWebViewModel.h"
#import "UICollectionViewCell+RACCommand.h"

@implementation HCGridMenuViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _gridMenuView = [HCGridMenuView new];
        _gridMenuView.delegate = self;
        [self.contentView addSubview:_gridMenuView];
        
        [_gridMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        _gridMenuView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)bindData:(id)data {
    HCModule *module = data;
    [_gridMenuView reloadDataWithTypes:module.data];
}

- (void)bindPush:(RACCommand *)push {
    self.push = push;
}

#pragma mark - HCGridMenuViewProtocol
- (void)HCGridMenuView:(HCGridMenuView *)menuView selectedAtGridInfo:(HCModuleData *)gridInfo {
    HCWebViewModel *viewModel = [HCWebViewModel new];
    [self.push execute:viewModel];
}

@end
