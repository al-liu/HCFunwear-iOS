//
//  MainStyleViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MainStyleViewController.h"
#import "GlobalContext.h"
#import "HCMainStyleViewModelServiceImp.h"
#import "MainStyleViewModel.h"
#import "HCTabBarViewModel.h"

#import "CategoryPageViewController.h"
#import "HomePageViewController.h"

#import "HCTabBarController.h"

@interface MainStyleViewController () <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>
{
    MainStyleViewModel *_mainStyleViewModel;
}

@end

@implementation MainStyleViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _jumpButton.layer.borderWidth = 1;
    _jumpButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    HCMainStyleViewModelServiceImp *styleViewModelServiceImpl = [HCMainStyleViewModelServiceImp new];
    _mainStyleViewModel = [[MainStyleViewModel alloc]initWithServices:styleViewModelServiceImpl];
    
    _firstStyle.chTitleLabel.text = @"男士";
    _firstStyle.enTitleLabel.text = @"MEN";
    _secondStyle.chTitleLabel.text = @"女士";
    _secondStyle.enTitleLabel.text = @"WOMEN";
    _thirdStyle.chTitleLabel.text = @"生活";
    _thirdStyle.enTitleLabel.text = @"LIFE";
 
    [_styleViewList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MainStyleView *view = obj;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(changeStyle:)];
        [view addGestureRecognizer:tap];
        
        view.alpha = 0;
    }];
    
    _advertImageView.image = _mainStyleViewModel.launchBannerImage;
    
    [_mainStyleViewModel.appConfigRequestCommand execute:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([GlobalContext ShareInstance].isShowAdvert) {
        _firstStyle.alpha = 1;
        _secondStyle.alpha = 1;
        _thirdStyle.alpha = 1;
        _jumpButton.alpha = 0;
    }
    else {
        _advertImageView.transform = CGAffineTransformScale(_advertImageView.transform, 1.5, 1.5);
        [UIView animateWithDuration:5 animations:^{
            _advertImageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f animations:^{
                _firstStyle.alpha = 1;
                _secondStyle.alpha = 1;
                _thirdStyle.alpha = 1;
                _jumpButton.alpha = 0;
            }];
        }];
        [GlobalContext ShareInstance].isShowAdvert = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}


- (void)changeStyle:(UITapGestureRecognizer *)tap {
    UIView *tapView = tap.view;
    NSString *changedCid ;
    if (tapView.tag == 1) {
        changedCid = @"1";
    }
    else if (tapView.tag == 2) {
        changedCid = @"2";
    }
    else if (tapView.tag == 3) {
        changedCid = @"4";
    }
    if (![changedCid isEqualToString:[GlobalContext ShareInstance].cid]) {
        //需要更新
        [GlobalContext ShareInstance].cid = changedCid;
        //更新FLAG
        HomePageViewController *homePageController = [GlobalContext ShareInstance].mainTabBarController.viewControllers[0];
        homePageController.homePageViewModel.refreshFlag = YES;
        
        CategoryPageViewController *categoryPageController = [GlobalContext ShareInstance].mainTabBarController.viewControllers[1];
        categoryPageController.categoryViewModel.refreshHotFlag = YES;
        categoryPageController.categoryViewModel.refreshCategoryFlag = YES;
        categoryPageController.categoryViewModel.refreshBrandFlag = YES;
    }
    
//    HCTabBarViewModel *tabBarVM = [HCTabBarViewModel new];
//    [_mainStyleViewModel.pushCommand execute:tabBarVM];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)jumpAnimation:(id)sender {
    [UIView animateWithDuration:0.5f animations:^{
        _firstStyle.alpha = 1;
        _secondStyle.alpha = 1;
        _thirdStyle.alpha = 1;
        _jumpButton.alpha = 0;
    }];
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
