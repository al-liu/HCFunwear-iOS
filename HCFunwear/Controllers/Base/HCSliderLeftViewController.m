//
//  HCSliderLeftViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCSliderLeftViewController.h"

@interface HCSliderLeftViewController ()

@end

@implementation HCSliderLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 0, 100, 100);
    button.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pop {
    [self dismissViewControllerAnimated:YES completion:nil];
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
