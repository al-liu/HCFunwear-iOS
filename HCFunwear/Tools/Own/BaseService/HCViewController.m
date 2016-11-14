//
//  HCViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/11/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCViewController.h"

@interface HCViewController ()

@property (nonatomic, strong, readwrite) HCBaseViewModel *viewModel;

@end

@implementation HCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithViewModel:(HCBaseViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)bindViewModel {};

@end
