//
//  InspirationStyleScrollView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/9.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "InspirationStyleScrollView.h"
#import "Masonry.h"
#import "GlobalColors.h"
#import "InspirationPageViewModel.h"

@implementation InspirationStyleScrollView {
    NSMutableArray *_styleButtonArray;
    UIScrollView *styleScrollView;
    InspirationPageViewModel *_viewModel;
    
    NSArray *_tabDataList;
}

- (instancetype)initWithDatas:(NSArray *)tabsList {
    self = [super init];
    if (self) {
        _currentIndex = 0;
        _tabDataList = tabsList;
        _styleButtonArray = [[NSMutableArray alloc]initWithCapacity:11];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentIndex = 0;
        _styleButtonArray = [[NSMutableArray alloc]initWithCapacity:11];
    }
    return self;
}

- (void)reloadWithTabs:(NSArray *)tabs {
    _tabDataList = tabs;
    _currentIndex = 0;
    [self initUI];
}

- (void)bindViewModel:(id)viewModel {
    _viewModel = viewModel;
    @weakify(self);
    [[RACObserve(_viewModel, inspInfos) skip:1] subscribeNext:^(HCInspirationInfos *infos) {
        @strongify(self);
        if (!self->_tabDataList || self->_tabDataList.count == 0) {
            [self initUI];
        }
    }];
}

- (void)initUI {
    
    NSArray *subviews = [self subviews];
    [subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    styleScrollView = ({
        UIScrollView *view = [UIScrollView new];
        view.delegate = self;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        view;
    });
    
//    NSArray *titlesArray = @[@"全部",@"实验室",@"咖啡馆",@"趋势",@"搭配",
//                             @"热闻",@"榜单",@"时髦运动",@"特辑",@"生活",@"美妆"];
    
    UIView *previousView = nil;
    for (int i = 0; i < _tabDataList.count; i++) {
        HCInfoTab *tab = _tabDataList[i];
        
        UIButton *styleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [styleButton setTitleColor:kTabNormalColor forState:UIControlStateNormal];
        styleButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [styleButton setTitle:tab.name forState:UIControlStateNormal];
        [styleScrollView addSubview:styleButton];
        
        [styleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.top.bottom.equalTo(self);
            if (previousView) {
                make.left.equalTo(previousView.mas_right).offset(20);
            }
            else {
                make.left.equalTo(styleScrollView).offset(20);
            }
            if (i == _tabDataList.count - 1) {
                make.right.equalTo(styleScrollView);
            }
        }];
        
        styleButton.tag = i;
        [styleButton addTarget:self action:@selector(selectedStyleAction:) forControlEvents:UIControlEventTouchUpInside];
        
        previousView = styleButton;
        [_styleButtonArray addObject:styleButton];
    }
    
    UIView *horizontalLine = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@.5f);
            make.bottom.equalTo(self);
            make.left.right.equalTo(self);
        }];
        view;
    });
    horizontalLine.backgroundColor = kCellLineColor;
    [self scrollPageWithIndex:0];
}

- (void)selectedStyleAction:(UIButton *)button {
    
    CGFloat midReferenceValue = CGRectGetMidX(self.frame);
    CGFloat centerLeftSpace = button.center.x;
    CGFloat centerRightSpace = styleScrollView.contentSize.width - centerLeftSpace;

    if (centerLeftSpace == midReferenceValue || button.tag == _currentIndex) {
        return;
    }
    //控制滚动
    else if (centerLeftSpace < midReferenceValue) {
        [styleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (centerRightSpace < midReferenceValue) {
        [styleScrollView setContentOffset:CGPointMake(styleScrollView.contentSize.width-CGRectGetWidth(styleScrollView.frame), 0) animated:YES];
    }
    else {
        CGPoint point = [styleScrollView convertPoint:button.center toView:self];
        if (point.x < midReferenceValue) { //左边
            CGFloat rightSpace = CGRectGetWidth(self.frame) - point.x;
            CGFloat offset = rightSpace - midReferenceValue;
            [styleScrollView setContentOffset:CGPointMake(styleScrollView.contentOffset.x - offset, 0) animated:YES];
        }
        else if (point.x > midReferenceValue) {//右边
            CGFloat offset = point.x - midReferenceValue;
            [styleScrollView setContentOffset:CGPointMake(styleScrollView.contentOffset.x + offset, 0) animated:YES];
        }
    }
    //
    _currentIndex = button.tag;
    [self scrollPageWithIndex:_currentIndex];
}

- (void)scrollPageWithIndex:(NSInteger)index {
    [_styleButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = _styleButtonArray[idx];
        [button setTitleColor:kTabNormalColor forState:UIControlStateNormal];
    }];
    UIButton *button = _styleButtonArray[index];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (_delegate && [_delegate respondsToSelector:@selector(inspirationStyleScrollView:pageIndex:tabInfo:)]) {
        HCInfoTab *tab = _tabDataList[_currentIndex];
        [_delegate inspirationStyleScrollView:self pageIndex:_currentIndex tabInfo:tab];
    }
}

- (void)scrollTabWithIndex:(NSInteger)index {
    [self selectedStyleAction:_styleButtonArray[index]];
}

#pragma mark - UIScrollViewDelelgate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    _currentIndex = scrollView.contentOffset.x / CGRectGetWidth(self.frame);
//    if (_delegate && [_delegate respondsToSelector:@selector(inspirationStyleScrollView:PageForIndex:)]) {
//        [_delegate inspirationStyleScrollView:self PageForIndex:_currentIndex];
//    }
//}

@end
