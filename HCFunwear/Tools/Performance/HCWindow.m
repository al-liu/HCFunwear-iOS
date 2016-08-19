//
//  HCWindow.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/19.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCWindow.h"

@implementation HCWindow

- (void)fpsLabelWithSwitch:(BOOL)on_off {
    if (!_fps_label) {
        CGRect windowbounds = self.bounds;
        _fps_label = [[YYFPSLabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(windowbounds)-90, 55, 30)];
        [self addSubview:_fps_label];
        _fps_label.userInteractionEnabled = YES;
    }
    _fps_label.hidden = !on_off;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
