//
//  MainStyleViewController.h
//  HCFunwear
//
//  Created by 刘海川 on 16/5/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainStyleView.h"

@interface MainStyleViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet MainStyleView *firstStyle;
@property (weak, nonatomic) IBOutlet MainStyleView *secondStyle;
@property (weak, nonatomic) IBOutlet MainStyleView *thirdStyle;

@property (strong, nonatomic) IBOutletCollection(MainStyleView) NSArray *styleViewList;

@property (weak, nonatomic) IBOutlet UIImageView *advertImageView;

@property (weak, nonatomic) IBOutlet UIButton *jumpButton;

@end
