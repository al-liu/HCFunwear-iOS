//
//  MainStyleViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MainStyleViewController.h"
#import "GlobalContext.h"
#import "HCHomeViewModelServiceImpl.h"
#import "MainStyleViewModel.h"
#import "HCTabBarViewModel.h"

@interface MainStyleViewController ()
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
    
    HCHomeViewModelServiceImpl *homeViewModelServiceImpl = [HCHomeViewModelServiceImpl new];
    _mainStyleViewModel = [[MainStyleViewModel alloc]initWithServices:homeViewModelServiceImpl];
    
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
    
    [_mainStyleViewModel.appConfigRequestCommand execute:nil];
}

- (void)changeStyle:(UITapGestureRecognizer *)tap {
    HCTabBarViewModel *tabBarVM = [HCTabBarViewModel new];
    [_mainStyleViewModel.pushCommand execute:tabBarVM];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[GlobalContext ShareInstance].rootController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[GlobalContext ShareInstance].rootController setNavigationBarHidden:NO animated:animated];
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
