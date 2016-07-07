//
//  TopCategoryView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/7.
//  Copyright © 1016年 Haichuan Liu. All rights reserved.
//

#import "TopCategoryView.h"
#import "Masonry.h"
#import "GlobalColors.h"

@implementation TopCategoryView {
    UILabel *_midLabel;
    UILabel *_leftLabel;
    UILabel *_rightLabel;
    UIView *_sliderView;
    
    NSArray *_labelArray;
}

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    //60 - 10
    _midLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kTabNormalColor;
        [self addSubview:label];
        
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
        [label addGestureRecognizer:tap];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.center.equalTo(self);
        }];
        
        label;
    });
    
    _leftLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kTabNormalColor;
        [self addSubview:label];
        
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
        [label addGestureRecognizer:tap];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.right.equalTo(_midLabel.mas_left).offset(-10);
            make.centerY.equalTo(self);
        }];
        
        label;
    });
    
    _rightLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kTabNormalColor;
        [self addSubview:label];
        
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
        [label addGestureRecognizer:tap];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.left.equalTo(_midLabel.mas_right).offset(10);
            make.centerY.equalTo(self);
        }];
        
        label;
    });
    
    _sliderView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.height.equalTo(@2);
            make.bottom.equalTo(self);
            make.centerX.equalTo(_rightLabel);
        }];
        
        view;
    });
    
    _leftLabel.tag = 0;
    _midLabel.tag = 1;
    _rightLabel.tag = 2;
    
    _labelArray = @[_leftLabel,_midLabel,_rightLabel];
    
}

- (void)setDelegate:(id<TopCategoryViewDelegate>)delegate {
    _delegate = delegate;
    
    if ([_delegate respondsToSelector:@selector(topCategoryView:labelForTitleAtIndex:)]) {
        _leftLabel.text = [_delegate topCategoryView:self labelForTitleAtIndex:0];
        _midLabel.text = [_delegate topCategoryView:self labelForTitleAtIndex:1];
        _rightLabel.text = [_delegate topCategoryView:self labelForTitleAtIndex:2];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [self actionWithIndex:_currentIndex];
}

#pragma mark - 更新约束

- (void)updateConstraints {
    
    [_sliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@2);
        make.bottom.equalTo(self);
        make.centerX.equalTo(_labelArray[_currentIndex]);
    }];

    //according to apple super should be called at end of method
    [super updateConstraints];
}


- (void)clickAction:(UITapGestureRecognizer *)tap {
    UIView *tapView = tap.view;
    _currentIndex = tapView.tag;

    [self actionWithIndex:_currentIndex];
}

- (void)actionWithIndex:(NSInteger)index {
    [_labelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = obj;
        label.textColor = kTabNormalColor;
    }];
    UILabel *label = _labelArray[index];
    label.textColor = [UIColor blackColor];
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(topCategoryView:clickAtIndex:)]) {
        [_delegate topCategoryView:self clickAtIndex:index];
    }
}

@end
