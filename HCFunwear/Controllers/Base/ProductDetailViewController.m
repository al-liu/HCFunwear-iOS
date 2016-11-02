//
//  ProductDetailViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "HCTopGoodsDetailView.h"
#import "Masonry.h"
#import "HCShoppingCartView.h"
#import "HCGoodsDetailRefreshFooter.h"
#import "HCBottomGoodsDetailView.h"
#import "GlobalContext.h"
#import "RACEXTScope.h"
#import "GlobalImport.h"
#import "HCHudManager.h"

#import "HCCounterView.h"

typedef NS_ENUM(NSUInteger,HCContentMoudleType) {
    HCContentMoudleTop,
    HCContentMoudleBottom
};

@interface ProductDetailViewController ()
{
    HCContentMoudleType _contentMoudleType;
    HCTopGoodsDetailView *_goodsDetailView;
    HCBottomGoodsDetailView *_bottomGoodsView;
    
    ProductDetailViewModel *_viewModel;
}
@end

@implementation ProductDetailViewController

- (instancetype)initWithViewModel:(ProductDetailViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configDetailNavigationBar];
    [[GlobalContext ShareInstance].rootController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[GlobalContext ShareInstance].rootController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentMoudleType = HCContentMoudleTop;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    
    _goodsDetailView = [HCTopGoodsDetailView new];
    [_goodsDetailView bindViewModel:_viewModel];
    [self.view addSubview:_goodsDetailView];
    
    [_goodsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    
    _goodsDetailView.scrollView.mj_footer = [HCGoodsDetailRefreshFooter footerWithRefreshingBlock:^{
        [_goodsDetailView.scrollView.mj_footer endRefreshing];
        
        //切换 bottom
        [self switchBottomView:HCContentMoudleBottom];
    }];
    
    _bottomGoodsView = [HCBottomGoodsDetailView new];
    [_bottomGoodsView bindViewModel:_viewModel];
    [self.view addSubview:_bottomGoodsView];
    
    [_bottomGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsDetailView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(_goodsDetailView.mas_height).offset(-64);
    }];
    
    @weakify(self)
    _bottomGoodsView.goBackBlock = ^(){
        @strongify(self)
        [self switchBottomView:HCContentMoudleTop];
    };
    
    HCShoppingCartView *shoppingCartView = [HCShoppingCartView new];
    [self.view addSubview:shoppingCartView];
    
    [shoppingCartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    [shoppingCartView bindAddGoodsCommand:_viewModel.addGoodsCommand];
    
    HCHudManager *hudManager = [HCHudManager new];
    [hudManager addHUDToView:self.navigationController.view];
    [hudManager show];
    
    [_viewModel.batchStream subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hudManager hidden];
        });
    }];
    
    
//    HCCounterView *counterView = [[UINib nibWithNibName:@"HCCounterView" bundle:nil] instantiateWithOwner:self options:nil].lastObject;
//    [self.view addSubview:counterView];
}

- (void)switchBottomView:(HCContentMoudleType)type {
    if (_contentMoudleType == type) {
        return;
    }
    _contentMoudleType = type;
    switch (_contentMoudleType) {
        case HCContentMoudleTop:
        {
            [[GlobalContext ShareInstance].rootController setNavigationBarHidden:YES];
        }
            break;
        case HCContentMoudleBottom:
        {
            [[GlobalContext ShareInstance].rootController setNavigationBarHidden:NO];
        }
            break;
        default:
            break;
    }
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (_contentMoudleType == HCContentMoudleTop) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _bottomGoodsView.isGoBackTop = NO;
            });
        }
    }];
}

- (void)updateViewConstraints {
    
//    NSLog(@"top height:%f",CGRectGetHeight(_goodsDetailView.frame));
//    NSLog(@"bottom height:%f",CGRectGetHeight(_bottomGoodsView.frame));
    CGFloat topHeight = CGRectGetHeight(_goodsDetailView.frame);
    CGFloat bottomHeight = CGRectGetHeight(_bottomGoodsView.frame);
    if (topHeight != 0 && bottomHeight != 0) {
        CGFloat offset = topHeight-64;
        if (_contentMoudleType == HCContentMoudleTop) {
            [_goodsDetailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.view);
                make.bottom.equalTo(self.view).offset(-50);
            }];
        }
        else {
            [_goodsDetailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).offset(-offset);
                make.left.right.equalTo(self.view);
                make.bottom.equalTo(self.view).offset(-50-offset);
            }];
        }
    }
    [super updateViewConstraints];
}

- (void)configDetailNavigationBar {
    
    self.titleLabel.text = @"单品详情";
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_share"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

@end
