//
//  HCCirculateScrollViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCCirculateScrollViewCell.h"
#import "Masonry.h"
#import "HCModule.h"
#import "HCWebViewModel.h"
#import "UICollectionViewCell+RACCommand.h"

@implementation HCCirculateScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _circulateScrollView = [HCCirculateScrollView new];
        _circulateScrollView.delegate = self;
        _circulateScrollView.image = [UIImage imageNamed:@"fan_default_01"];
        [self.contentView addSubview:_circulateScrollView];
        
        [_circulateScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)bindData:(id)data {
    HCModule *module = data;
    NSArray *urlStrings = [[module.data.rac_sequence map:^id(HCModuleData *value) {
        return value.img;
    }] array];
    [_circulateScrollView loadView:urlStrings];
}

- (void)bindPush:(RACCommand *)push {
    self.push = push;
}

#pragma mark - HCCirculateScrollViewProtocol
- (void)circulateScrollViewDidSelectedAtIndex:(NSInteger)index {
    HCWebViewModel *viewModel = [HCWebViewModel new];
    [self.push execute:viewModel];
}
- (void)circulateScrollViewPageControlAtIndex:(NSInteger)index {
    
}

@end
