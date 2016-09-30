//
//  HCProductDetailAppraiseView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailAppraiseView.h"
#import "HCAppraiseScoreView.h"
#import "Masonry.h"
#import "HCAppraiseCell.h"
#import "GlobalImport.h"
#import "HCAppraiseOnlyTextCell.h"
#import "HCCommentListModel.h"
#import "HCAppraiseNoReplyCell.h"
#import "HCAppraiseOnlyTextNoReplyCell.h"

static CGFloat kOffset = 100.0;
@interface HCProductDetailAppraiseView () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *_appraiseTableView;
    
//    HCAppraiseCell *_referenceCell;
//    HCAppraiseOnlyTextCell *_referenceOnlyTextCell;
//    HCAppraiseNoReplyCell *_referenceNoReplyCell;
//    HCAppraiseOnlyTextNoReplyCell *_referenceOnlyTextNoReplyCell;
    
    NSDictionary *_referenceCellList;
}

@property (nonatomic,strong)NSArray *list;

@end

@implementation HCProductDetailAppraiseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        HCAppraiseCell *referenceCell = [[HCAppraiseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        HCAppraiseOnlyTextCell *referenceOnlyTextCell = [[HCAppraiseOnlyTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        HCAppraiseNoReplyCell *referenceNoReplyCell = [[HCAppraiseNoReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        HCAppraiseOnlyTextNoReplyCell *referenceOnlyTextNoReplyCell = [[HCAppraiseOnlyTextNoReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        _referenceCellList = @{kAppraiseCellIdentifier:referenceCell,
                               kAppraiseNoReplyCellIdentifier:referenceNoReplyCell,
                               kAppraiseOnlyTextCellIdentifier:referenceOnlyTextCell,
                               kAppraiseOnlyTextNoReplyCellIdentifier:referenceOnlyTextNoReplyCell};
        [self initUI];
    }
    return self;
}

- (void)initUI {
    HCAppraiseScoreView *scoreView = ({
        HCAppraiseScoreView *view = [HCAppraiseScoreView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@40);
        }];
        
        view;
    });
    
    _appraiseTableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        [self addSubview:tableView];
        
        [tableView registerClass:[HCAppraiseCell class] forCellReuseIdentifier:kAppraiseCellIdentifier];
        [tableView registerClass:[HCAppraiseOnlyTextCell class] forCellReuseIdentifier:kAppraiseOnlyTextCellIdentifier];
        [tableView registerClass:[HCAppraiseNoReplyCell class] forCellReuseIdentifier:kAppraiseNoReplyCellIdentifier];
        [tableView registerClass:[HCAppraiseOnlyTextNoReplyCell class] forCellReuseIdentifier:kAppraiseOnlyTextNoReplyCellIdentifier];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scoreView.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];
        
        tableView;
    });
    
}

- (void)reloadData:(NSArray *)list {
    _list = list;
    [_appraiseTableView reloadData];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    DDLogInfo(@"offset scroll :%f",scrollView.contentOffset.y);
    //暂按100算
    if (scrollView.contentOffset.y < -kOffset) {
        if (_delegate && [_delegate respondsToSelector:@selector(productDetailBottomGoBackTop)]) {
            [_delegate productDetailBottomGoBackTop];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HCCommentListModel *model = _list[indexPath.row];
    UITableViewCell<HCAppraiseCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:model.cellIdentifier forIndexPath:indexPath];
    [cell setData:model];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCCommentListModel *model = _list[indexPath.row];
    UITableViewCell<HCAppraiseCellProtocol> *cell = _referenceCellList[model.cellIdentifier];
    [cell setData:model];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

@end
