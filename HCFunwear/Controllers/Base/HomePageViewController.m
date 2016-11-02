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
#import "HCHomeCollectionViewBindingHelper.h"
#import "ReactiveCocoa.h"
#import "ProductDetailViewController.h"

#import "MainStyleViewController.h"
#import "CategoryPageViewController.h"
#import "GlobalConfig.h"

#import "HCSliderLeftPresentAnimator.h"
#import "HCSliderLeftDismissAnimator.h"
#import "HCSliderLeftViewController.h"
@interface HomePageViewController ()
<
    TopStyleDelegate,
    UIViewControllerTransitioningDelegate
>

@property (strong, nonatomic) HomePageView *homePageView;

@property (strong, nonatomic) HCSliderLeftPresentAnimator *animator;

@end

@implementation HomePageViewController

#pragma mark - life_cycle

- (instancetype)initWithViewModel:(HomePageViewModel *)viewModel {
    self = [super init];
    if (self ) {
        self.homePageViewModel = viewModel;
        _animator = [HCSliderLeftPresentAnimator new];
        @weakify(self);
        _animator.gobackSliderLeftBlock = ^(){
            @strongify(self);
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self bindViewModel];
 
    @weakify(self);
    [RACObserve(_homePageViewModel, refreshFlag) subscribeNext:^(id x) {
        if ([x  isEqual: @YES]) {
            @strongify(self);
            [self->_homePageView beginRefresh];
            self->_homePageViewModel.refreshFlag = NO;
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

    _homePageView = [[HomePageView alloc]initWithViewModel:_homePageViewModel];
    [self.view addSubview:_homePageView];
    
    [_homePageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-49);
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
    }];
}

- (void)bindViewModel {
    //先请求布局数据
    [self.homePageViewModel.layoutRequestCommand execute:nil];
    
    [HCHomeCollectionViewBindingHelper initWithCollectionView:_homePageView.homePageCollectionView
                                                 sourceSignal:RACObserve(self.homePageViewModel, layoutDataArray)
                                               productsSignal:RACObserve(self.homePageViewModel, productsDataArray)
                                                  pushCommand:self.homePageViewModel.pushCommand];
}

#pragma mark - configration
- (void)configNavigationBar {
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 58);
    [leftButton setImage:[UIImage imageNamed:@"top_cebian"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(toSliderLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 58, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = rightItem;
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = screenSize.width;
    TopStyleButton *topStyleButton = [[TopStyleButton alloc]initWithFrame:CGRectMake(0, 0, screenWidth-180, 44)];
    topStyleButton.delegate = self;
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.titleView = topStyleButton;
    
    if ([[GlobalContext ShareInstance].cid isEqualToString:@"1"]) {
        topStyleButton.funwearStyle = ManFunwearStyle;
    }
    else if ([[GlobalContext ShareInstance].cid isEqualToString:@"2"]) {
        topStyleButton.funwearStyle = WomenFunwearStyle;
    }
    else if ([[GlobalContext ShareInstance].cid isEqualToString:@"4"]) {
        topStyleButton.funwearStyle = LifeFunwearStyle;
    }
    
    /*
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [[GlobalContext ShareInstance].rootController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"top_back"]];
    [[GlobalContext ShareInstance].rootController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"top_back"]];
    [[GlobalContext ShareInstance].rootController.navigationBar setTintColor:[UIColor blackColor]];
     */
}



#pragma mark - TopStyleDelegate
- (NSString *)topStyleButton:(TopStyleButton *)button cellForTitleAtIndexPath:(NSIndexPath *)indexPath {
    return _homePageViewModel.topStyleTitleArray[indexPath.row];
}

- (void)topStyleButton:(TopStyleButton *)button didSelectStyle:(FunwearStyle )style {
    //处理全局 cid
    NSString *changedCid ;
    if (style == ManFunwearStyle) {
        changedCid = @"1";
    }
    else if (style == WomenFunwearStyle) {
        changedCid = @"2";
    }
    else if (style == LifeFunwearStyle) {
        changedCid = @"4";
    }
    
    if (![changedCid isEqualToString:[GlobalContext ShareInstance].cid]) {
        //需要更新
        [GlobalContext ShareInstance].cid = changedCid;
        //更新FLAG
        self.homePageViewModel.refreshFlag = YES;
        [_homePageView beginRefresh];
        
        CategoryPageViewController *categoryPageController = [GlobalContext ShareInstance].mainTabBarController.viewControllers[1];
        categoryPageController.categoryViewModel.refreshHotFlag = YES;
        categoryPageController.categoryViewModel.refreshCategoryFlag = YES;
        categoryPageController.categoryViewModel.refreshBrandFlag = YES;
    }
}

#pragma mark - 侧滑
- (void)toSliderLeft {
    HCSliderLeftViewController *viewController = [[HCSliderLeftViewController alloc]init];
    viewController.transitioningDelegate = self;
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - 定制转场动画 (Present 与 Dismiss动画代理)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    return _animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    HCSliderLeftDismissAnimator *dismissAnimator   = [HCSliderLeftDismissAnimator new];
    // 退出控制器动画
    return dismissAnimator;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
