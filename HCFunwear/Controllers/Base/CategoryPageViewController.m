//
//  CategoryPageViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "CategoryPageViewController.h"
#import "GlobalContext.h"
#import "TopCategoryView.h"
#import "Masonry.h"
#import "TopHotPageView.h"
#import "TopCategoryPageView.h"
#import "TopBrandPageView.h"
#import "CategoryPageViewModel.h"
#import "HCCategoryLayout.h"
#import "GlobalConstant.h"

@interface CategoryPageViewController () {
    TopCategoryView *topView;
    UIScrollView *_scrollView;
    TopHotPageView *_topHotPageView;
    TopCategoryPageView *_topCategoryPageView;
    TopBrandPageView *_topBrandPageView;
}

@end

@implementation CategoryPageViewController

#pragma mark - life_cycle

- (instancetype)initWithViewModel:(CategoryPageViewModel *)viewModel {
    self = [super init];
    if (self) {
        _categoryViewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self topCategoryView:topView clickAtIndex:0];
    
    RACSignal *signal01 = RACObserve(_categoryViewModel, refreshHotFlag);
    RACSignal *signal02 = RACObserve(_categoryViewModel, refreshCategoryFlag);
    RACSignal *signal03 = RACObserve(_categoryViewModel, refreshBrandFlag);
    NSArray *signalArray = @[signal01,signal02,signal03];
    @weakify(self);
    [[RACSignal merge:signalArray] subscribeNext:^(id x) {
        @strongify(self);
        if ([x isEqual:@YES]) {
            [self beginRequestWithIndex:topView.currentIndex];
            [self configNavigationBar];
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initUI 
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    topView = [[TopCategoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, 44)];
//    topView.backgroundColor = [UIColor redColor];
    topView.delegate = self;
    
    _scrollView = ({
        UIScrollView *view = [UIScrollView new];
        view.pagingEnabled = YES;
        view.delegate = self;
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        view;
    });
    
    NSNumber *pageWidth = [NSNumber numberWithFloat:CGRectGetWidth(self.view.frame)];
    
    _topHotPageView = ({
        TopHotPageView *view = [TopHotPageView new];
        [view bindViewModel:_categoryViewModel];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view).offset(64);
            make.left.equalTo(_scrollView);
            make.width.equalTo(pageWidth);
        }];
        
        view;
    });
    
    _topCategoryPageView = ({
        TopCategoryPageView *view = [TopCategoryPageView new];
        [view bindViewModel:_categoryViewModel];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topHotPageView.mas_right);
            make.top.bottom.width.equalTo(_topHotPageView);
        }];
        
        view;
    });
    
    _topBrandPageView = ({
        TopBrandPageView *view = [TopBrandPageView new];
        [view bindViewModel:_categoryViewModel];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topCategoryPageView.mas_right);
            make.top.bottom.width.equalTo(_topHotPageView);
            make.right.equalTo(_scrollView);
        }];
        
        view;
    });
    
}

- (void)beginRequestWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            if (!self.categoryViewModel.hotLayout | self.categoryViewModel.refreshHotFlag) {
                [_topHotPageView beginRefresh];
                self.categoryViewModel.refreshHotFlag = NO;
            }
        }
            break;
        case 1:
        {
            if ((self.categoryViewModel.cateList.count == 0) | self.categoryViewModel.refreshCategoryFlag) {
                [_topCategoryPageView beginRefresh];
                self.categoryViewModel.refreshCategoryFlag = NO;
            }
        }
            break;
        case 2:
        {
            if ((self.categoryViewModel.brandList.count == 0) | self.categoryViewModel.refreshBrandFlag) {
                [_topBrandPageView beginRefresh];
                self.categoryViewModel.refreshBrandFlag = NO;
            }
        }
            break;
        default:
            NSAssert1(false, @"beginRequestWithIndex:index:%ld 值不为0/1/2。", index);
            break;
    }
}

#pragma mark - configration
- (void)configNavigationBar {
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [leftButton setImage:[UIImage imageNamed:@"top_cebian"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = rightItem;
    
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.titleView = topView;
    
}

#pragma mark - TopCategoryViewDelegate
- (NSString *)topCategoryView:(TopCategoryView *)topCategoryView labelForTitleAtIndex:(NSInteger)index {
    return self.categoryViewModel.topTitlesList[index];
}

- (void)topCategoryView:(TopCategoryView *)topCategoryView clickAtIndex:(NSInteger)index {
    [self beginRequestWithIndex:index];
    [_scrollView setContentOffset:CGPointMake(index * CGRectGetWidth(_scrollView.frame), 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    topView.currentIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    [self beginRequestWithIndex:topView.currentIndex];
}

@end
