//
//  HCFunwearRefreshHeader.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/17.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCFunwearRefreshHeader.h"
#import <CoreText/CoreText.h>

@implementation HCFunwearRefreshHeader {
    CALayer *_backgroundLayer;
    CAShapeLayer *_pathLayer;
    CAGradientLayer *_gradientLayer;
}

- (void)prepare {
    [super prepare];
    _backgroundLayer = [CALayer layer];
    [self.layer addSublayer:_backgroundLayer];
    /*
    _gradientLayer = [CAGradientLayer layer];
    [self.layer addSublayer:_gradientLayer];
    _gradientLayer.colors = @[
                             (__bridge id)[UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:.5].CGColor,
                             (__bridge id)[UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:1].CGColor,
                             (__bridge id)[UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:.5].CGColor,                             ];
    _gradientLayer.locations = @[@0.25,@0.5,@0.75];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(1, 1);
    
    // 添加部分
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    basicAnimation.fromValue = @[@0, @0, @0.25];
    basicAnimation.toValue = @[@0.75, @1, @1];
    basicAnimation.duration = 2.5;
    basicAnimation.repeatCount = HUGE;
    [_gradientLayer addAnimation:basicAnimation forKey:nil];
     */
}

- (void)placeSubviews {
    [super placeSubviews];
    _backgroundLayer.frame = self.bounds;
//    _gradientLayer.frame = self.bounds;
    [self setupTextLayer];
    [self startAnimation];
    
//    _gradientLayer.mask = _pathLayer;
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    NSLog(@"pullingPercent:%f",pullingPercent);
    if (pullingPercent > 0.5) {
        CGFloat fixPullingPercent =  (pullingPercent - 0.5)*20;
        CGFloat processValue =+ fixPullingPercent;
        _pathLayer.timeOffset = processValue;
    }
    
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            /** 普通闲置状态 */
            _pathLayer.timeOffset = 0;
            break;
        case MJRefreshStatePulling:
            /** 松开就可以进行刷新的状态 */
            _pathLayer.timeOffset = 10;
            break;
        case MJRefreshStateRefreshing:
            /** 正在刷新中的状态 */
            _pathLayer.timeOffset = 10;
            //辉光 FUNWEAR
            break;
        case MJRefreshStateWillRefresh:
            /** 即将刷新的状态 */
            _pathLayer.timeOffset = 10;
            break;
        case MJRefreshStateNoMoreData:
            /** 所有数据加载完毕，没有更多的数据了 */
        default:
            break;
    }
}

#pragma mark - 获取文字路径/创建动画
- (void)setupTextLayer
{
    if (_pathLayer != nil) {
        [_pathLayer removeFromSuperlayer];
        _pathLayer = nil;
    }
    
    // Create path from text
    // See: http://www.codeproject.com/KB/iPhone/Glyph.aspx
    // License: The Code Project Open License (CPOL) 1.02 http://www.codeproject.com/info/cpol10.aspx
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-UltraLight"), 15.0f, NULL);
    NSNumber *wordSpace = [NSNumber numberWithFloat:3.0];
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           wordSpace,NSKernAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"FUNWEAR"
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            // Get PATH of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = _backgroundLayer.frame;
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:1].CGColor;
    // pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [_backgroundLayer addSublayer:pathLayer];
    
    _pathLayer.speed = 0;
    _pathLayer.timeOffset = 0;
    
    _pathLayer = pathLayer;
}
- (void) startAnimation
{
    [_pathLayer removeAllAnimations];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [_pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

@end
