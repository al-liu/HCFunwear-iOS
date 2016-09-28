//
//  HCBottomGoodsDetailView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCBottomGoodsDetailView.h"
#import "HCSelectedMoudleView.h"
#import "Masonry.h"
#import "HCProductDetailCollectionView.h"
#import "HCProductDetailAppraiseView.h"
#import "HCProductDetailNoticeView.h"
#import "RACEXTScope.h"

@interface HCBottomGoodsDetailView () <UIScrollViewDelegate,HCProductDetailProtocol>
{
    HCSelectedMoudleView *_selectedMoudleView;
    
}
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HCBottomGoodsDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isGoBackTop = NO;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //Selected Moudle
    _selectedMoudleView = [[HCSelectedMoudleView alloc]initWithTitles:@[@"商品详情",@"全部评价(0)",@"购买咨询"]];
    [self addSubview:_selectedMoudleView];
    
    [_selectedMoudleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@43);
    }];
    
    @weakify(self)
    _selectedMoudleView.selectedMoudleBlock = ^(NSUInteger index) {
        @strongify(self)
        CGFloat offset = CGRectGetWidth(self.scrollView.frame) * index;
        [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    };
    
    //scorll view
    self.scrollView = ({
        UIScrollView *view = [UIScrollView new];
        view.pagingEnabled = YES;
        view.delegate = self;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_selectedMoudleView.mas_bottom);
            make.bottom.left.right.equalTo(self);
        }];
        
        view;
    });
    
    HCProductDetailCollectionView *detailCollectionView = ({
        HCProductDetailCollectionView *view = [HCProductDetailCollectionView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.scrollView);
            make.width.equalTo(self);
            make.height.equalTo(self.mas_height).offset(-43);
        }];
        
        view;
    });
    
    HCProductDetailAppraiseView *detailAppraiseView = ({
        HCProductDetailAppraiseView *view = [HCProductDetailAppraiseView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.scrollView);
            make.left.equalTo(detailCollectionView.mas_right);
            make.width.equalTo(self);
            make.height.equalTo(detailCollectionView);
        }];
        
        view;
    });
    
    HCProductDetailNoticeView *detailNoticeView = ({
        HCProductDetailNoticeView *view = [HCProductDetailNoticeView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.scrollView);
            make.left.equalTo(detailAppraiseView.mas_right);
            make.width.equalTo(self);
            make.height.equalTo(detailAppraiseView);
        }];
        
        view;
    });

    detailCollectionView.delegate = self;
    detailAppraiseView.delegate = self;
    detailNoticeView.delegate = self;
}

#pragma mark - HCProductDetailProtocol
- (void)productDetailBottomGoBackTop {
    if (_isGoBackTop) {
        return;
    }
    NSLog(@"productDetailBottomGoBackTop");
    _isGoBackTop = YES;
    if (_goBackBlock) {
        self.goBackBlock();
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    [_selectedMoudleView selectedWithIndex:index];
}

@end
