//
//  YYFPSLabel+draw.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/19.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "YYFPSLabel+draw.h"
#import "HCWindow.h"
#import "GlobalContext.h"

@implementation YYFPSLabel (draw)

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    HCWindow *window = [GlobalContext ShareInstance].applicationWindow;
    CGPoint move_point = [[touches anyObject] locationInView:window];
    self.center = move_point;
}


@end
