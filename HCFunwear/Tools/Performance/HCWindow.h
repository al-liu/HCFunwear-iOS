//
//  HCWindow.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/19.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYFPSLabel.h"

@interface HCWindow : UIWindow

@property (nonatomic, strong) YYFPSLabel *fps_label;

//是否显示 FPS Label
- (void)fpsLabelWithSwitch:(BOOL)on_off;

@end
