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
    
    InspirationPageInfoView *_pageInfoView;
    InspirationPageFunerView *_funnerView;
    
    InspirationPageAttentionView *_attentionView;
}
@end

@implementation InspirationPageViewController

#pragma mark - life_cycle
- (instancetype)initWithViewModel:(InspirationPageViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    [[_viewModel.infosRequestCommand execute:nil] subscribeNext:^(HCInspirationInfos *info) {
        [_pageInfoView reloadWithTabs:info.attr];
    }];
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    topView = [[TopCategoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, 44)];
    topView.delegate = self;

    _scrollView = ({
        UIScrollView *view = [UIScrollView new];
        view.pagingEnabled = YES;
        view.delegate = self;
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view).offset(64);
//            make.bottom.left.right.equalTo(self.view);
            
            make.edges.equalTo(self.view);
        }];
        
        view;
    });
    
    NSNumber *pageWidth = [NSNumber numberWithFloat:CGRectGetWidth(self.view.frame)];
    
    _pageInfoView = ({
        InspirationPageInfoView *view = [[InspirationPageInfoView alloc] initWithViewModel:_viewModel];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollView).offset(64);
            make.bottom.equalTo(_scrollView);
//            make.top.bottom.equalTo(_scrollView);
            make.left.equalTo(_scrollView);
            make.width.equalTo(pageWidth);
            make.height.equalTo(self.view).offset(-64);
        }];
        
        view;
    });
    
    _funnerView = ({
        InspirationPageFunerView *view = [InspirationPageFunerView new];
        [view bindViewModel:_viewModel];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_pageInfoView.mas_right);
            make.top.bottom.width.height.equalTo(_pageInfoView);
        }];
        
        view;
    });
    
    _attentionView = ({
        InspirationPageAttentionView *view = [InspirationPageAttentionView new];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_funnerView.mas_right);
            make.top.bottom.width.height.equalTo(_funnerView);
            make.right.equalTo(_scrollView);
        }];
        
        view;
    });
    
}

#pragma mark - configration
- (void)configNavigationBar {
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = rightItem;
    
//    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = nil;
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.titleView = topView;
}

#pragma mark - TopCategoryViewDelegate
- (NSString *)topCategoryView:(TopCategoryView *)topCategoryView labelForTitleAtIndex:(NSInteger)index {
    return _viewModel.topTitlesList[index];
}

- (void)topCategoryView:(TopCategoryView *)topCategoryView clickAtIndex:(NSInteger)index {
    
    [_scrollView setContentOffset:CGPointMake(index * CGRectGetWidth(_scrollView.frame), 0) animated:YES];
    if (index == 1) {
        if (_funnerView.funerDataList.count == 0) {
            [_funnerView header_beginRefreshing];
        }
    }
    else if (topView.currentIndex == 2) {
        //登陆
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    topView.currentIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    if (topView.currentIndex == 1) {
        if (_funnerView.funerDataList.count == 0) {
            [_funnerView header_beginRefreshing];
        }
    }
    else if (topView.currentIndex == 2) {
        //登陆
    }
}

@end
