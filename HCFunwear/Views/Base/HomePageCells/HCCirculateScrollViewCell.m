//
//  HCCirculateScrollViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCCirculateScrollViewCell.h"
#import "Masonry.h"

@implementation HCCirculateScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         _circulateScrollView = [HCCirculateScrollView new];
        _circulateScrollView.image = [UIImage imageNamed:@"fan_default_01"];
        [self.contentView addSubview:_circulateScrollView];
        
        [_circulateScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        if (_cellDelegate) {
            _circulateScrollView.delegate = _cellDelegate;
        }
    }
    return self;
}

@end
