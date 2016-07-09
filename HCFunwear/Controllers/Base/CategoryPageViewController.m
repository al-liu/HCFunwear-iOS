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

@interface CategoryPageViewController () {
    TopCategoryView *topView;
    UIScrollView *_scrollView;
}

@end

@implementation CategoryPageViewController

#pragma mark - life_cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initUI 
- (void)initUI {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = screenSize.width;
    topView = [[TopCategoryView alloc]initWithFrame:CGRectMake(0, 0, screenWidth-180, 44)];
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
    
    TopHotPageView *topHotPageView = ({
        TopHotPageView *view = [TopHotPageView new];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view).offset(64);
            make.left.equalTo(_scrollView);
            make.width.equalTo(pageWidth);
        }];
        
        view;
    });
    
    TopCategoryPageView *topCategoryPageView = ({
        TopCategoryPageView *view = [TopCategoryPageView new];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topHotPageView.mas_right);
            make.top.bottom.width.equalTo(topHotPageView);
        }];
        
        view;
    });
    
    TopBrandPageView *topBrandPageView = ({
        TopBrandPageView *view = [TopBrandPageView new];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topCategoryPageView.mas_right);
            make.top.bottom.width.equalTo(topHotPageView);
            make.right.equalTo(_scrollView);
        }];
        
        view;
    });
    
}

#pragma mark - configration
- (void)configNavigationBar {
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 58);
    [leftButton setImage:[UIImage imageNamed:@"top_cebian"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 58, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = rightItem;
    
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.titleView = topView;
}

#pragma mark - TopCategoryViewDelegate
- (NSString *)topCategoryView:(TopCategoryView *)topCategoryView labelForTitleAtIndex:(NSInteger)index {
    NSArray *titleArray = @[@"热门",@"品类",@"品牌"];
    return titleArray[index];
}

- (void)topCategoryView:(TopCategoryView *)topCategoryView clickAtIndex:(NSInteger)index {
    [_scrollView setContentOffset:CGPointMake(index * CGRectGetWidth(_scrollView.frame), 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    topView.currentIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
}

@end
