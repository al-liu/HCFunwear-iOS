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
#import "HCProductDetailStyleViewController.h"

@interface MainStyleViewController ()
{
    MainStyleViewModel *_mainStyleViewModel;
}

@end

@implementation MainStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _jumpButton.layer.borderWidth = 1;
    _jumpButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
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

        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        [view addGestureRecognizer:tap];
        
        [[tap.rac_gestureSignal map:^id(UITapGestureRecognizer *tap) {
            return @(tap.view.tag);
        }] subscribeNext:^(NSNumber *x) {
            [[_mainStyleViewModel.tapCommand execute:x] subscribeNext:^(id x) {
                RACTuple *tuple = x;
                NSString *cid = tuple.first;
                BOOL isRefresh = [tuple.second boolValue];
                
                //需要更新
                [GlobalContext ShareInstance].cid = cid;
                //更新FLAG
                HomePageViewController *homePageController = [GlobalContext ShareInstance].mainTabBarController.viewControllers[0];
                homePageController.homePageViewModel.refreshFlag = isRefresh;
                
                CategoryPageViewController *categoryPageController = [GlobalContext ShareInstance].mainTabBarController.viewControllers[1];
                categoryPageController.categoryViewModel.refreshHotFlag = isRefresh;
                categoryPageController.categoryViewModel.refreshCategoryFlag = isRefresh;
                categoryPageController.categoryViewModel.refreshBrandFlag = isRefresh;
            }];
        }];
        
        view.alpha = 0;
    }];
    
    _advertImageView.image = _mainStyleViewModel.launchBannerImage;
    
    [_mainStyleViewModel.appConfigRequestCommand execute:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([GlobalContext ShareInstance].isShowAdvert) {
        [self showStyleButton];
    }
    else {
        _advertImageView.transform = CGAffineTransformScale(_advertImageView.transform, 1.5, 1.5);
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _advertImageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f animations:^{
                [self showStyleButton];
            }];
        }];
        [GlobalContext ShareInstance].isShowAdvert = YES;
    }
}

- (void)showStyleButton {
    _firstStyle.alpha = 1;
    _secondStyle.alpha = 1;
    _thirdStyle.alpha = 1;
    _jumpButton.alpha = 0;
}

- (IBAction)jumpAnimation:(id)sender {
    [UIView animateWithDuration:0.5f animations:^{
        _firstStyle.alpha = 1;
        _secondStyle.alpha = 1;
        _thirdStyle.alpha = 1;
        _jumpButton.alpha = 0;
    }];
}

@end
