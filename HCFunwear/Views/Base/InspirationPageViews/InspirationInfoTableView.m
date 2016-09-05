//
//  InspirationInfoTableView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/9.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "InspirationInfoTableView.h"
#import "Masonry.h"
#import "InspirationInfoCell.h"
#import "GlobalConstant.h"
#import "HCFunwearRefreshHeader.h"
#import "HCFunwearRefreshFooter.h"
#import "ReactiveCocoa.h"
#import "RACEXTScope.h"
#import "InspirationPageViewModel.h"
#import "HCInspInfoModel.h"
#import "UIImageView+HCPackWebImage.h"

@implementation InspirationInfoTableView {
    NSArray *_tabsList;
    NSMutableArray *_tableViewList;
    UIScrollView *styleScrollView;
    InspirationPageViewModel *_viewModel;
}

- (instancetype)initWithDatas:(NSArray *)tabsList {
    self = [super init];
    if (self) {
        _tabsList = tabsList;
        _currentIndex = 0;
        [self initUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tabsList = nil;
        _currentIndex = 0;
        [self initUI];
    }
    return self;
}

- (void)reloadWithTabs:(NSArray *)tabs {
    _tabsList = tabs;
    _currentIndex = 0;
    [self initUI];
}

- (void)initUI {
    
    NSArray *subviews = [self subviews];
    [subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    styleScrollView = ({
        UIScrollView *view = [UIScrollView new];
        view.delegate = self;
        view.pagingEnabled = YES;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        view;
    });
    
    
//    NSArray *titlesArray = @[@"全部",@"实验室",@"咖啡馆",@"趋势",@"搭配",
//                             @"热闻",@"榜单",@"时髦运动",@"特辑",@"生活",@"美妆"];
    _tableArray = [NSMutableArray array];
    _tableViewList = [NSMutableArray array];
    UIView *previousView = nil;
    for (int i = 0; i < _tabsList.count; i++) {
        HCInfoTab *tab = _tabsList[i];
        HCInspInfoModel *model = [[HCInspInfoModel alloc] initWithAID:tab.tab_id];
        
        [_tableArray addObject:model];
        
        UITableView *tableView = ({
            UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            view.separatorStyle = UITableViewCellSeparatorStyleNone;
            [styleScrollView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.width.height.equalTo(self);
                if (previousView) {
                    make.left.equalTo(previousView.mas_right);
                }
                else {
                    make.left.equalTo(styleScrollView);
                }
                if (i == _tabsList.count - 1) {
                    make.right.equalTo(styleScrollView);
                }
            }];
            
            view;
        });
        
        [tableView registerNib:[UINib nibWithNibName:@"InspirationInfoCell" bundle:nil] forCellReuseIdentifier:kInspirationInfoCellIdentifier];
        
        previousView = tableView;
        
        [_tableViewList addObject:tableView];
        tableView.dataSource = self;
        tableView.delegate = self;
        
        tableView.mj_header = [HCFunwearRefreshHeader headerWithRefreshingBlock:^{
            UITableView *tableView = self->_tableViewList[self->_currentIndex];
            HCInspInfoModel *model = self->_tableArray[self->_currentIndex];
            
            HCInfoTab *tab = _tabsList[i];
            model = [[HCInspInfoModel alloc] initWithAID:tab.tab_id];
            
            _viewModel.infoPageIndex = model.pageIndex;
            _viewModel.infoPageSize = model.pageSize;
            _viewModel.infoAid = model.infoAid;
            [[_viewModel.infosRequestCommand execute:nil] subscribeNext:^(HCInspirationInfos *info) {
                [tableView.mj_header endRefreshing];
            }];
        }];
        
        tableView.mj_footer = [HCFunwearRefreshFooter footerWithRefreshingBlock:^{
            UITableView *tableView = self->_tableViewList[self->_currentIndex];
            HCInspInfoModel *model = self->_tableArray[self->_currentIndex];
            model.pageIndex += 1;
            
            _viewModel.infoPageIndex = model.pageIndex;
            _viewModel.infoPageSize = model.pageSize;
            _viewModel.infoAid = model.infoAid;
            [[_viewModel.infosRequestCommand execute:nil] subscribeNext:^(HCInspirationInfos *info) {
                [tableView.mj_footer endRefreshing];
            }];
        }];
        
    }
    
}

- (void)aaaa {
    
}

- (void)header_beginRefreshing {
//    HCInspInfoModel *model = self->_tableArray.firstObject;//全部
    //将之前获取的数据设置进去
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UITableView *tableView = self->_tableViewList[self->_currentIndex];
        [tableView.mj_header beginRefreshing];
    });
    
    /*
    if (_viewModel.inspInfos.list.count != 0 && model.tableInfosList.count == 0) {
        [model.tableInfosList addObjectsFromArray:_viewModel.inspInfos.list];
        
        [tableView reloadData];
    }
    else {
        [tableView.mj_header beginRefreshing];
    }
     */
}

- (void)bindViewModel:(id)viewModel {
    _viewModel = viewModel;
    @weakify(self);
    [[RACObserve(_viewModel, inspInfos) skip:1] subscribeNext:^(HCInspirationInfos *infos) {
        @strongify(self);
        UITableView *tableView = self->_tableViewList[self->_currentIndex];
        HCInspInfoModel *model = self->_tableArray[self->_currentIndex];
        [model.tableInfosList addObjectsFromArray:infos.list];
        [tableView reloadData];
    }];
}

- (void)scrollTabWithIndex:(NSInteger)index {
    _currentIndex = index;
    [styleScrollView setContentOffset:CGPointMake(_currentIndex * CGRectGetWidth(self.frame), 0) animated:NO];
}

#pragma mark - UIScrollViewDelelgate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //不要用scrollView 用 styleScrollView
    _currentIndex = styleScrollView.contentOffset.x / CGRectGetWidth(self.frame);
    if (_delegate && [_delegate respondsToSelector:@selector(inspirationInfoTableView:pageForIndex:)]) {
        [_delegate inspirationInfoTableView:self pageForIndex:_currentIndex];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger tableViewIndex = [_tableViewList indexOfObject:tableView];
    HCInspInfoModel *model = self->_tableArray[tableViewIndex];
    return model.tableInfosList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InspirationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kInspirationInfoCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger tableViewIndex = [_tableViewList indexOfObject:tableView];
    HCInspInfoModel *model = self->_tableArray[tableViewIndex];
    HCInspInfo *info = model.tableInfosList[indexPath.row];
    
    [cell.inspImageView packAspectFitModeSetImageWithURL:info.img placeholder:defaultImage02];
    cell.nameLabel.text = info.title;
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //64:47
    return SCREEN_WIDTH / 64.0 *47;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}


@end
