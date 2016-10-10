//
//  MainStyleViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MainStyleViewController.h"
#import "GlobalContext.h"

@interface MainStyleViewController ()

@end

@implementation MainStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _firstStyle.chTitleLabel.text = @"男士";
    _firstStyle.enTitleLabel.text = @"MEN";
    _secondStyle.chTitleLabel.text = @"女士";
    _secondStyle.enTitleLabel.text = @"WOMEN";
    _thirdStyle.chTitleLabel.text = @"生活";
    _thirdStyle.enTitleLabel.text = @"LIFE";
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[GlobalContext ShareInstance].rootController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[GlobalContext ShareInstance].rootController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
