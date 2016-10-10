//
//  HomePageViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HomePageViewController.h"
#import "TopStyleButton.h"
#import "GlobalContext.h"
#import "HomePageView.h"
#import "RACEXTScope.h"
#import "HCHomeCollectionViewBindingHelper.h"
#import "ReactiveCocoa.h"
#import "ProductDetailViewController.h"

@interface HomePageViewController ()
<
    TopStyleDelegate
>

@property (weak, nonatomic) HomePageViewModel *homePageViewModel;
@property (strong, nonatomic) HomePageView *homePageView;

@end

@implementation HomePageViewController

#pragma mark - life_cycle

- (instancetype)initWithViewModel:(HomePageViewModel *)viewModel {
    self = [super init];
    if (self ) {
        self.homePageViewModel = viewModel;
    }
    return self;
}

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
