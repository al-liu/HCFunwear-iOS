//
//  TopStyleButton.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "TopStyleButton.h"
#import "Masonry.h"
#import "GlobalContext.h"
#import "GlobalColors.h"

static CGFloat kRowHeight = 44;
static NSString *kStyleCellIdentifier = @"kStyleCellIdentifier";

@implementation TopStyleButton {
    UIControl *_board;
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIView *topView = [UIView new];
    topView.userInteractionEnabled = NO;
    [self addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    UILabel *label = [UILabel new];
    label.userInteractionEnabled = NO;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"男生";
    [topView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(topView);
    }];
    
    _imageView = [UIImageView new];
    _imageView.userInteractionEnabled = NO;
    _imageView.image = [UIImage imageNamed:@"top_filter_down_arrow"];
    [topView addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label);
        make.left.equalTo(label.mas_right).offset(5);
        make.right.equalTo(topView).offset(-5);
    }];
}

- (void)clickAction:(UIButton *)button {
    _isShow = !_isShow;
    [self arrowAnimationWithIsShow:_isShow];
    if (_isShow) {
        [self displayBoard];
    }
    else {
        [self hideBoard];
    }
}

- (void)arrowAnimationWithIsShow:(BOOL)flag {
    [UIView animateWithDuration:.3f animations:^{
        CGAffineTransform transform = _imageView.transform;
        transform = CGAffineTransformRotate(transform, M_PI);
        _imageView.transform = transform;
    }];
}

- (void)displayBoard {
    _board = [[UIControl alloc] initWithFrame:CGRectZero];
    _board.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    [[GlobalContext ShareInstance].applicationWindow addSubview:_board];

    [_board mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([GlobalContext ShareInstance].applicationWindow).offset(64);
        make.left.right.bottom.equalTo([GlobalContext ShareInstance].applicationWindow);
    }];
    
    
    
    UITableView *optionsTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    optionsTableView.dataSource = self;
    optionsTableView.delegate = self;
    optionsTableView.backgroundColor = [UIColor whiteColor];
    optionsTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_board addSubview:optionsTableView];
    
    [optionsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_board);
        make.height.equalTo(@132);
    }];
}

- (void)hideBoard {
    if (_board) {
        [_board removeFromSuperview];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStyleCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kStyleCellIdentifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        if (_delegate && [_delegate respondsToSelector:@selector(topStyleButton:cellForTitleAtIndexPath:)]) {
            cell.textLabel.text = [_delegate topStyleButton:self cellForTitleAtIndexPath:indexPath];
        }
        else {
            cell.textLabel.text = @"not respondsToSelector cellForTitleAtIndexPath";
        }
        UIView *line = [UIView new];
        line.backgroundColor = kCellLineColor;
        [cell.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@.5);
            make.left.right.bottom.equalTo(cell.contentView);
        }];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            _funwearStyle = ManFunwearStyle;
            break;
        case 1:
            _funwearStyle = WomenFunwearStyle;
            break;
        case 2:
            _funwearStyle = LifeFunwearStyle;
            break;
        default:
            break;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(topStyleButton:didSelectStyle:)]) {
        [_delegate topStyleButton:self didSelectStyle:_funwearStyle];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
