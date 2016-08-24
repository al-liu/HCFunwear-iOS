//
//  InspirationPageInfoView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "InspirationPageInfoView.h"
#import "InspirationStyleScrollView.h"
#import "Masonry.h"
#import "InspirationInfoTableView.h"
#import "HCInspInfoModel.h"

@interface InspirationPageInfoView () <InspirationStyleScrollDelegate,InspirationInfoTableDelegate>

@end

@implementation InspirationPageInfoView {
    InspirationStyleScrollView *_styleScrollView;
    InspirationInfoTableView *_infoTableView;
    
    InspirationPageViewModel *_viewModel;
}

- (instancetype)initWithViewModel:(InspirationPageViewModel *)viewModel {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _viewModel = viewModel;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //h:42
    _styleScrollView = ({
        InspirationStyleScrollView *view = [InspirationStyleScrollView new];
        view.delegate = self;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(@42);
        }];
    
        view;
    });
    
    _infoTableView = ({
        InspirationInfoTableView *view = [InspirationInfoTableView new];
        view.delegate = self;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_styleScrollView.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];
        
        view;
    });
    
}

- (void)reloadWithTabs:(NSArray *)tabs {
    [_styleScrollView reloadWithTabs:tabs];
    [_infoTableView reloadWithTabs:tabs];
    [_styleScrollView bindViewModel:_viewModel];
    [_infoTableView bindViewModel:_viewModel];
    [self beginRequestWithIndex:0];    
}

- (void)beginRequestWithIndex:(NSInteger)index {
    HCInspInfoModel *model = _infoTableView.tableArray[index];
    if (model.tableInfosList.count == 0) {
        [_infoTableView header_beginRefreshing];
    }
}

#pragma mark - InspirationStyleScrollDelegate
- (void)inspirationStyleScrollView:(InspirationStyleScrollView *)infoView
                         pageIndex:(NSInteger)indx
                           tabInfo:(HCInfoTab *)tab {
    if (indx != _infoTableView.currentIndex) {
        [_infoTableView scrollTabWithIndex:indx];
        [self beginRequestWithIndex:indx];
    }
}

#pragma mark - InspirationInfoTableDelegate
- (void)inspirationInfoTableView:(InspirationInfoTableView *)infoView
                    pageForIndex:(NSInteger)indx {
    if (indx != _styleScrollView.currentIndex) {
        [_styleScrollView scrollTabWithIndex:indx];
        [self beginRequestWithIndex:indx];
    }
}

@end
