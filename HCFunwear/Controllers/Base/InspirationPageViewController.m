//
//  InspirationPageViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "InspirationPageViewController.h"
#import "GlobalContext.h"
#import "TopCategoryView.h"
#import "GlobalConstant.h"
#import "InspirationPageInfoView.h"
#import "Masonry.h"
#import "InspirationPageFunerView.h"
#import "InspirationPageAttentionView.h"

@interface InspirationPageViewController () <TopCategoryViewDelegate>
{
    TopCategoryView *topView;
    UIScrollView *_scrollView;
}
@end

@implementation InspirationPageViewController

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
    topView = [[TopCategoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-180, 44)];
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
    
    InspirationPageInfoView *pageInfoView = ({
        InspirationPageInfoView *view = [InspirationPageInfoView new];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view).offset(64);
            make.left.equalTo(_scrollView);
            make.width.equalTo(pageWidth);
        }];
        
        view;
    });
    
    InspirationPageFunerView *funnerView = ({
        InspirationPageFunerView *view = [InspirationPageFunerView new];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pageInfoView.mas_right);
            make.top.bottom.width.equalTo(pageInfoView);
        }];
        
        view;
    });
    
    InspirationPageAttentionView *attentionView = ({
        InspirationPageAttentionView *view = [InspirationPageAttentionView new];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(funnerView.mas_right);
            make.top.bottom.width.equalTo(funnerView);
            make.right.equalTo(_scrollView);
        }];
        
        view;
    });
    
}

#pragma mark - configration
- (void)configNavigationBar {
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 58, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = rightItem;
    
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.titleView = topView;
}

#pragma mark - TopCategoryViewDelegate
- (NSString *)topCategoryView:(TopCategoryView *)topCategoryView labelForTitleAtIndex:(NSInteger)index {
    NSArray *titleArray = @[@"资讯",@"范儿",@"关注"];
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
