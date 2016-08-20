//
//  TopCategoryPageView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "TopCategoryPageView.h"
#import "Masonry.h"
#import "GlobalConstant.h"
#import "CategoryTableViewCell.h"
#import "UIImageView+Image.h"
#import "HCFunwearRefreshHeader.h"
#import "RACEXTScope.h"

@implementation TopCategoryPageView {
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
    _tableView = ({
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        view.dataSource = self;
        view.delegate = self;
        view.separatorColor = [UIColor whiteColor];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        view;
    });
    [_tableView registerNib:[UINib nibWithNibName:@"CategoryTableViewCell" bundle:nil] forCellReuseIdentifier:kCategoryTableViewCellIdentifier];
    
    @weakify(self);
    _tableView.mj_header = [HCFunwearRefreshHeader headerWithRefreshingBlock:^{
        [[self.cateViewModel.categorysRequestCommand execute:nil] subscribeNext:^(NSArray *categorys) {
            @strongify(self);
            self.categoryArray = categorys;
            [self reload];
            [_tableView.mj_header endRefreshing];
        }];
    }];
}

- (void)reload {
    [_tableView reloadData];
}
- (void)beginRefresh {
    [_tableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCategoryTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HCCategory *data = _categoryArray[indexPath.row];
    [cell.cateImageView toloadImageWithURL:data.img placeholder:defaultImage03];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //116 39
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat rowHeight = (screenWidth - 30) / 116.0 * 39;
    return rowHeight + 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

@end
