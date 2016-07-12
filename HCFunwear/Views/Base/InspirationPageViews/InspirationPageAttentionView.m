//
//  InspirationPageAttentionView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "InspirationPageAttentionView.h"
#import "Masonry.h"
#import "InspirationAttentionCell.h"
#import "GlobalConstant.h"
#import "InspirationAttentionHeaderView.h"
#import "InspirationNotAttentionView.h"

static CGFloat rowHeight = 60;
static CGFloat headerHeight = 26;

@implementation InspirationPageAttentionView {
    UITableView *_tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor orangeColor];
    _tableView = ({
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        view.dataSource = self;
        view.delegate = self;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        view;
    });
    _tableView.backgroundColor = [UIColor redColor];
    [_tableView registerNib:[UINib nibWithNibName:@"InspirationAttentionCell" bundle:nil] forCellReuseIdentifier:kInspirationAttentionCellIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InspirationAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:kInspirationAttentionCellIdentifier forIndexPath:indexPath];
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    InspirationAttentionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"InspirationAttentionHeaderView" owner:self options:nil] lastObject];
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    InspirationNotAttentionView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"InspirationNotAttentionView" owner:self options:nil] lastObject];
    return footerView;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat footerHeight = CGRectGetHeight(tableView.frame) - rowHeight - headerHeight;
    return footerHeight;
}

@end
