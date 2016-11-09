//
//  HCCounterView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/11/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCCounterView.h"
#import "UIColor+YYAdd.h"
#import "XXNibBridge.h"

@interface HCCounterView () <XXNibBridge>

@property (weak, nonatomic) IBOutlet UIButton *subtractButton;
@property (weak, nonatomic) IBOutlet UIButton *increaseButton;
@property (weak, nonatomic) IBOutlet UIButton *countButton;

@property (nonatomic, assign, readwrite) NSInteger countValue;

@end

@implementation HCCounterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
    _countValue = 0;
    _minCount = NSIntegerMin;
    _maxCount = NSIntegerMax;
    
}

- (void)resetCount:(NSInteger)count {
    _countValue = count;
    NSString * countStr = [NSString stringWithFormat:@"%ld",count];
    [_countButton setTitle:countStr forState:UIControlStateNormal];
}

- (IBAction)subtractAction:(id)sender {
    if (_countValue == _minCount) {
        return;
    }
    _countValue--;
    [self resetCount:_countValue];
}

- (IBAction)increaseAction:(id)sender {
    if (_countValue == _maxCount) {
        return;
    }
    _countValue++;
    [self resetCount:_countValue];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
