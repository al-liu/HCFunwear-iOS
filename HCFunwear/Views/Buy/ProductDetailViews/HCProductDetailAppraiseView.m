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

static NSString *kAppraiseCellIdentifier = @"kAppraiseCellIdentifier";
static NSString *kAppraiseOnlyTextCellIdentifier = @"kAppraiseOnlyTextCellIdentifier";

@interface HCProductDetailAppraiseView () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_appraiseTableView;
    HCAppraiseCell *_referenceCell;
    HCAppraiseOnlyTextCell *_referenceOnlyTextCell;
}
@end

@implementation HCProductDetailAppraiseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _referenceCell = [[HCAppraiseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _referenceOnlyTextCell = [[HCAppraiseOnlyTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
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
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scoreView.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];
        
        tableView;
    });
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        HCAppraiseOnlyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kAppraiseOnlyTextCellIdentifier forIndexPath:indexPath];
        [cell setData];
        return cell;
    }
    else {
        HCAppraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:kAppraiseCellIdentifier forIndexPath:indexPath];
        [cell setData];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0) {
        [_referenceOnlyTextCell setData];
        CGSize size = [_referenceOnlyTextCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        DDLogDebug(@"row size index:%ld-%@",indexPath.row,NSStringFromCGSize(size));
        return size.height+10;
    }
    else {
        [_referenceCell setData];
        CGSize size = [_referenceCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        DDLogDebug(@"row size index:%ld-%@",indexPath.row,NSStringFromCGSize(size));
        return size.height+10;
    }
    
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
