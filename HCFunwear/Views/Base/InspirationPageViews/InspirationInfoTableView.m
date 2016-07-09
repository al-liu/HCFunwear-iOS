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

@implementation InspirationInfoTableView {
    UIScrollView *styleScrollView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
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
    
    
    NSArray *titlesArray = @[@"全部",@"实验室",@"咖啡馆",@"趋势",@"搭配",
                             @"热闻",@"榜单",@"时髦运动",@"特辑",@"生活",@"美妆"];
    
    UIView *previousView = nil;
    for (int i = 0; i < titlesArray.count; i++) {
        UITableView *tableView = ({
            UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            view.dataSource = self;
            view.delegate = self;
            [styleScrollView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self);
                make.height.equalTo(self);
                if (previousView) {
                    make.left.equalTo(previousView.mas_right);
                }
                else {
                    make.left.equalTo(styleScrollView);
                }
                if (i == titlesArray.count - 1) {
                    make.right.equalTo(styleScrollView);
                }
            }];
            
            view;
        });
        
        [tableView registerNib:[UINib nibWithNibName:@"InspirationInfoCell" bundle:nil] forCellReuseIdentifier:kInspirationInfoCellIdentifier];
        
        previousView = tableView;
    }
    
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [styleScrollView setContentOffset:CGPointMake(_currentIndex * CGRectGetWidth(self.frame), 0) animated:YES];
}

#pragma mark - UIScrollViewDelelgate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentIndex = scrollView.contentOffset.x / CGRectGetWidth(self.frame);
    if (_delegate && [_delegate respondsToSelector:@selector(inspirationInfoTableView:PageForIndex:)]) {
        [_delegate inspirationInfoTableView:self PageForIndex:_currentIndex];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InspirationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kInspirationInfoCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
