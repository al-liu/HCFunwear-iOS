//
//  SinglePageAdvertViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "SinglePageAdvertViewCell.h"
#import "GlobalColors.h"
#import "Masonry.h"
#import "HCModule.h"
#import "UICollectionViewCell+RACCommand.h"
#import "HCWebViewModel.h"
#import "RACEXTScope.h"
#import "UIImageView+HCPackWebImage.h"
#import "GlobalConstant.h"

@implementation SinglePageAdvertViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _advertView = [UIImageView new];
        _advertView.backgroundColor = [UIColor whiteColor];
        _advertView.contentMode = UIViewContentModeCenter;
        _advertView.image = [UIImage imageNamed:@"fan_default_02"];
        _advertView.userInteractionEnabled = YES;
        [self.contentView addSubview:_advertView];
        
        [_advertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [_advertView addGestureRecognizer:tap];
        @weakify(self);
        [tap.rac_gestureSignal subscribeNext:^(id x) {
            @strongify(self);
            HCWebViewModel *viewModel = [HCWebViewModel new];
            [self.push execute:viewModel];
        }];
        
    }
    return self;
}

- (void)bindData:(id)data {
    HCModule *module = data;
    HCModuleData *moudleData = module.data.firstObject;
    
    [_advertView packAspectFitModeSetImageWithURL:moudleData.img placeholder:defaultImage03];

}

- (void)bindPush:(RACCommand *)push {
    self.push = push;
}

@end
