//
//  HCProductDetailNoticeView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailNoticeView.h"
#import "Masonry.h"
#import "HCBuyQACell.h"

static NSString *kBuyQACellIdentifier = @"kBuyQACellIdentifier";

static CGFloat kOffset = 100.0;
@interface HCProductDetailNoticeView () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *_noticeTableView;
    HCBuyQACell *_referenceCell;
}

@property (nonatomic,strong)NSArray *list;

@end

@implementation HCProductDetailNoticeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _referenceCell = [[HCBuyQACell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _noticeTableView = ({
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.backgroundColor = [UIColor whiteColor];
            [self addSubview:tableView];
            
            [tableView registerClass:[HCBuyQACell class] forCellReuseIdentifier:kBuyQACellIdentifier];
            
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            
            tableView;
        });
    }
    return self;
}

- (void)reloadData:(NSArray *)list {
    _list = list;
    [_noticeTableView reloadData];
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
    HCBuyQACell *cell = [tableView dequeueReusableCellWithIdentifier:kBuyQACellIdentifier forIndexPath:indexPath];
    HCProductQAModel *model = _list[indexPath.row];
    [cell setData:model];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCProductQAModel *model = _list[indexPath.row];
    [_referenceCell setData:model];
    CGSize size = [_referenceCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
