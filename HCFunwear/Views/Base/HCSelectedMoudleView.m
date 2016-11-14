//
//  HCSelectedMoudleView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCSelectedMoudleView.h"
#import "Masonry.h"

#define NORMAL_COLOER [UIColor colorWithWhite:0.659 alpha:1.000]
#define SELECTED_COLOER [UIColor blackColor] 

CGFloat const LINE_SPACE = 18.0;
CGFloat const LINE_HEIGHT = 2.0;

@interface HCSelectedMoudleView ()
{
    NSMutableArray *_btnArray;
    UIView *_line;
    NSUInteger _selectedIndex;
}
@end

@implementation HCSelectedMoudleView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _btnArray = [[NSMutableArray alloc]initWithCapacity:titles.count];
        _selectedIndex = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self initUI:titles];
    }
    return self;
}

- (void)initUI:(NSArray *)titles {
    if (titles.count == 0) {
        return;
    }
    //根据 titles 布局 button
    UIView *lastView = self;
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn setTitleColor:NORMAL_COLOER forState:UIControlStateNormal];
        [btn setTitleColor:SELECTED_COLOER forState:UIControlStateSelected];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setAdjustsImageWhenHighlighted:NO];
        [btn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            if (i == 0) {
                make.left.equalTo(self);
                btn.selected = YES;
            }
            else if (i == titles.count - 1) {
                make.right.equalTo(self);
                make.left.equalTo(lastView.mas_right);
                make.width.equalTo(lastView.mas_width);
            }
            else {
                make.left.equalTo(lastView.mas_right);
                make.width.equalTo(lastView.mas_width);
            }
        }];
        
        lastView = btn;
        [_btnArray addObject:btn];
        
    }
    
    _line = [UIView new];
    _line.backgroundColor = [UIColor blackColor];
    [self addSubview:_line];
    
//    UIButton *firstBtn = _btnArray.firstObject;
//    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(LINE_HEIGHT));
//        make.bottom.equalTo(self);
//        make.width.equalTo(lastView.mas_width).offset(-LINE_SPACE*2);
//        make.centerX.equalTo(firstBtn.mas_centerX);
//    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = NORMAL_COLOER;
    [self addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5f);
        make.bottom.left.right.equalTo(self);
    }];
}

- (void)selectedAction:(UIButton *)selectedButton {
    if (selectedButton.tag == _selectedIndex) {
        return;
    }
    [self selectedWithIndex:selectedButton.tag];
}

- (void)setAppraiseTitle:(NSString *)title {
    if (_btnArray.count == 3) {
        UIButton *secondBtn = _btnArray[1];
        [secondBtn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)selectedWithIndex:(NSUInteger)index {
    [_btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        btn.selected = NO;
    }];
    UIButton *selectedButton = _btnArray[index];
    selectedButton.selected = YES;
    _selectedIndex = index;
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectedMoudleView:selectedIndex:)]) {
        [_delegate selectedMoudleView:self selectedIndex:_selectedIndex];
    }
    if (_selectedMoudleBlock) {
        _selectedMoudleBlock(_selectedIndex);
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)updateConstraints {
    UIButton *selectedBtn = _btnArray[_selectedIndex];

    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(LINE_HEIGHT));
        make.bottom.equalTo(self);
        make.width.equalTo(selectedBtn.mas_width).offset(-LINE_SPACE*2);
        make.centerX.equalTo(selectedBtn.mas_centerX);
    }];

    //according to apple super should be called at end of method
    [super updateConstraints];
}

@end
