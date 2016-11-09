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
#import "ProductDetailViewModel.h"
#import "UIImageView+HCPackWebImage.h"
#import "UIButton+WebCache.h"
#import "HCWebViewModel.h"

@interface HCTopGoodsDetailView () <UITableViewDataSource,UITableViewDelegate>
{
    HCGoodsDetailShowPictureView *_showPictureView;
    HCGoodsPriceView *_goodsPriceView;
    UIButton *_explainButton;
    UITableView *_shopPlanTabelView;
    HCGoodsDetailShopView *_shopView;
    
}
@property (nonatomic, strong) RACCommand *push;

@property (nonatomic, strong)ProductDetailViewModel *detailViewModel;

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
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
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
            make.right.equalTo(@-15);
            make.top.equalTo(@25);
            make.width.height.equalTo(@32);
        }];
        
        button;
    });
    [backBtn setImage:[UIImage imageNamed:@"top_back_y"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"top_share_y"] forState:UIControlStateNormal];
    
    //图片浏览 320:388.5
    _showPictureView = ({
        HCGoodsDetailShowPictureView *view = [HCGoodsDetailShowPictureView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView).offset(-20);
            make.left.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(388/320.0);
        }];
        
        view;
    });
    
    //价格和名字
    _goodsPriceView = ({
        HCGoodsPriceView *view = [HCGoodsPriceView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(_showPictureView.mas_bottom);
        }];
        
        view;
    });
    
    //保障 320:38
    _explainButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.showsTouchWhenHighlighted = NO;
        button.backgroundColor = [UIColor whiteColor];
        button.adjustsImageWhenHighlighted = NO;
        [button addTarget:self action:@selector(explainAction) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(_goodsPriceView.mas_bottom);
            make.height.equalTo(self.mas_width).multipliedBy(38/320.0);
        }];
        
        button;
    });
    
    //这里是根据活动数量动态展示的
    DDLogWarn(@"HCTopGoodsDetailView 需要 数据动态生成 UI");
    
    //包邮 h:44
    _shopPlanTabelView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.scrollView addSubview:tableView];
        
        [tableView registerNib:[UINib nibWithNibName:@"HCGoodsDetailShopPlanCell" bundle:nil] forCellReuseIdentifier:kHCGoodsDetailShopPlanCellIdentifier];
        
//        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_explainButton.mas_bottom).offset(8);
//            make.left.right.equalTo(self);
//            make.height.equalTo(@88);//暂时写死
//        }];
        
        tableView;
    });
    
    _shopView = ({
        HCGoodsDetailShopView *view = [[UINib nibWithNibName:@"HCGoodsDetailShopView" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_shopPlanTabelView.mas_bottom).offset(8);
            make.left.right.equalTo(self);
            make.height.equalTo(@75);
            make.bottom.equalTo(self.scrollView).offset(-8);
        }];
        
        view;
    });
}

- (void)backAction {
    [[GlobalContext ShareInstance].rootController popViewControllerAnimated:YES];
}

- (void)explainAction {
    HCWebViewModel *viewModel = [HCWebViewModel new];
    viewModel.webRequestURL = _detailViewModel.productDetailModel.brandDispatchGoods.url;
    viewModel.webTitle = @"用户协议";
    [self.push execute:viewModel];
}

#pragma mark - updateConstraints
- (void)updateConstraints {
    CGFloat tableHeight = 44 * _detailViewModel.productDetailModel.activity.count;
    [_shopPlanTabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_explainButton.mas_bottom).offset(8);
        make.left.right.equalTo(self);
        make.height.equalTo(@(tableHeight));
    }];
    
    [super updateConstraints];
}

#pragma mark - HCViewModelBindProtocol
- (void)bindViewModel:(id)viewModel {
    _detailViewModel = viewModel;
    @weakify(self)
    [[RACObserve(_detailViewModel, productDetailModel) skip:1] subscribeNext:^(HCProductDetailModel *data) {
        @strongify(self)
        [self->_showPictureView reloadData:data.proPicUrl];
        [self->_goodsPriceView reloadData:data.clsInfo];
        [self->_explainButton sd_setImageWithURL:data.brandDispatchGoods.img forState:UIControlStateNormal];
        [self->_shopView.shopLogoImageView packAspectFillModeSetImageWithURL:[NSURL URLWithString:data.clsInfo.brandUrl]
                                                                 placeholder:defaultImage03];
        self->_shopView.shopNameLabel.text = data.clsInfo.brand;
        [self->_shopPlanTabelView reloadData];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }];
}
- (void)bindPush:(RACCommand *)push {
    self.push = push;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _detailViewModel.productDetailModel.activity.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCGoodsDetailShopPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:kHCGoodsDetailShopPlanCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HCActivity *activity = _detailViewModel.productDetailModel.activity[indexPath.row];
    cell.planContentLabel.text = activity.name;
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
