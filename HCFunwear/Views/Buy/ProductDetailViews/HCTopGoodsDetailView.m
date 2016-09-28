//
//  HCTopGoodsDetailView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCTopGoodsDetailView.h"
#import "HCGoodsDetailShowPictureView.h"
#import "Masonry.h"
#import "HCGoodsPriceView.h"
#import "GlobalImport.h"
#import "HCGoodsDetailShopPlanCell.h"
#import "HCGoodsDetailShopView.h"
#import "HCGoodsDetailRefreshFooter.h"

@interface HCTopGoodsDetailView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HCTopGoodsDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = kBaseViewBGColor;
    
    
    
    self.scrollView = ({
        UIScrollView *view = [UIScrollView new];
//        view.delegate = self;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        view;
    });
    
    //t-25 l/r:15 返回和分享
    UIButton *backBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@25);
            make.width.height.equalTo(@32);
        }];
        
        button;
    });
    
    UIButton *shareBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@15);
            make.top.equalTo(@25);
            make.width.height.equalTo(@32);
        }];
        
        button;
    });
    [backBtn setImage:[UIImage imageNamed:@"top_back_y"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"top_share_y"] forState:UIControlStateNormal];
    
    //图片浏览 320:388.5
    HCGoodsDetailShowPictureView *showPictureView = ({
        HCGoodsDetailShowPictureView *view = [HCGoodsDetailShowPictureView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            make.left.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(388/320.0);
        }];
        
        view;
    });
    
    //价格和名字
    HCGoodsPriceView *goodsPriceView = ({
        HCGoodsPriceView *view = [HCGoodsPriceView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(showPictureView.mas_bottom);
        }];
        
        view;
    });
    
    //保障 320:38
    UIButton *explainButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.showsTouchWhenHighlighted = NO;
        button.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(goodsPriceView.mas_bottom);
            make.height.equalTo(self.mas_width).multipliedBy(38/320.0);
        }];
        
        button;
    });
    explainButton.backgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:0.745 alpha:1.000];//一张图片
    
    //这里是根据活动数量动态展示的
    DDLogWarn(@"HCTopGoodsDetailView 需要 数据动态生成 UI");
    
    //包邮 h:44
    UITableView *shopPlanTabelView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.scrollView addSubview:tableView];
        
        [tableView registerNib:[UINib nibWithNibName:@"HCGoodsDetailShopPlanCell" bundle:nil] forCellReuseIdentifier:kHCGoodsDetailShopPlanCellIdentifier];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(explainButton.mas_bottom).offset(8);
            make.left.right.equalTo(self);
            make.height.equalTo(@88);//暂时写死
        }];
        
        tableView;
    });
    
    HCGoodsDetailShopView *shopView = ({
        HCGoodsDetailShopView *view = [[UINib nibWithNibName:@"HCGoodsDetailShopView" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shopPlanTabelView.mas_bottom).offset(8);
            make.left.right.equalTo(self);
            make.height.equalTo(@75);
            make.bottom.equalTo(self.scrollView).offset(-8);
        }];
        
        view;
    });
    
    self.scrollView.mj_footer = [HCGoodsDetailRefreshFooter footerWithRefreshingBlock:^{
        [self.scrollView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCGoodsDetailShopPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:kHCGoodsDetailShopPlanCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

@end
