//
//  HomePageViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HomePageViewController.h"
#import "TopStyleButton.h"
#import "GlobalImport.h"
#import "HomePageView.h"
#import "RACEXTScope.h"
#import "ReactiveCocoa.h"
#import "ProductDetailViewController.h"
#import "HCHomeCollectionViewBindingHelper.h"


#import "MainStyleViewController.h"
#import "CategoryPageViewController.h"
#import "GlobalConfig.h"

#import "HCSliderLeftViewModel.h"
@interface HomePageViewController ()
<
    TopStyleDelegate
>
{
    TopStyleButton *_topStyleButton;
}

@property (strong, nonatomic) HomePageView *homePageView;

@property (strong, nonatomic, readonly) HomePageViewModel *viewModel;

@end

@implementation HomePageViewController

@dynamic viewModel;

#pragma mark - life_cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self bindViewModel];
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}

#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];

    _homePageView = [[HomePageView alloc]initWithViewModel:self.viewModel];
    [self.view addSubview:_homePageView];
    
    [_homePageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-49);
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
    }];

}

- (void)bindViewModel {
    //先请求布局数据
    [self.viewModel.layoutRequestCommand execute:nil];
    
    [HCHomeCollectionViewBindingHelper initWithCollectionView:_homePageView.homePageCollectionView
                                                 sourceSignal:RACObserve(self.viewModel, layoutDataArray)
                                               productsSignal:RACObserve(self.viewModel, productsDataArray)
                                                  pushCommand:self.viewModel.pushCommand];
    
    @weakify(self);
    [RACObserve(self.viewModel, refreshFlag) subscribeNext:^(id x) {
        if ([x  isEqual: @YES]) {
            @strongify(self);
            [self->_homePageView beginRefresh];
            self.viewModel.refreshFlag = NO;
            [self updateHomePageTopStyle];
        }
    }];
    
}

- (void)setRefreshFlag:(BOOL)flag {
    self.viewModel.refreshFlag = flag;
}

#pragma mark - configration
- (void)configNavigationBar {
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 58);
    [leftButton setImage:[UIImage imageNamed:@"top_cebian"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = leftItem;
    
    @weakify(self);
    [[leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        HCSliderLeftViewModel *sliderViewModel = [HCSliderLeftViewModel new];
        [self.viewModel.toLeftSideCommand execute:sliderViewModel];
    }];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 58, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = rightItem;
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = screenSize.width;
    
    _topStyleButton = [[TopStyleButton alloc]initWithFrame:CGRectMake(0, 0, screenWidth-180, 44)];
    _topStyleButton.delegate = self;
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.titleView = _topStyleButton;
    
    [self updateHomePageTopStyle];
}

- (void)updateHomePageTopStyle {
    if ([[GlobalContext ShareInstance].cid isEqualToString:@"1"]) {
        _topStyleButton.funwearStyle = ManFunwearStyle;
    }
    else if ([[GlobalContext ShareInstance].cid isEqualToString:@"2"]) {
        _topStyleButton.funwearStyle = WomenFunwearStyle;
    }
    else if ([[GlobalContext ShareInstance].cid isEqualToString:@"4"]) {
        _topStyleButton.funwearStyle = LifeFunwearStyle;
    }
}

#pragma mark - TopStyleDelegate
- (NSString *)topStyleButton:(TopStyleButton *)button cellForTitleAtIndexPath:(NSIndexPath *)indexPath {
    return self.viewModel.topStyleTitleArray[indexPath.row];
}

- (void)topStyleButton:(TopStyleButton *)button didSelectStyle:(FunwearStyle )style {
    @weakify(self);
    //处理全局 cid
    [[self.viewModel.tapCommand execute:@(style)] subscribeNext:^(id x) {
        @strongify(self);
        RACTuple *tuple = x;
        NSString *cid = tuple.first;
        BOOL isRefresh = [tuple.second boolValue];
        //需要更新
        [GlobalContext ShareInstance].cid = cid;
        //更新FLAG
        self.viewModel.refreshFlag = YES;
        [_homePageView beginRefresh];
        
        CategoryPageViewController *categoryPageController = [GlobalContext ShareInstance].mainTabBarController.viewControllers[1];
        categoryPageController.categoryViewModel.refreshHotFlag = isRefresh;
        categoryPageController.categoryViewModel.refreshCategoryFlag = isRefresh;
        categoryPageController.categoryViewModel.refreshBrandFlag = isRefresh;
    }];
}

@end
