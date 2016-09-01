//
//  HCFunwearRefreshHeader.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/17.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCFunwearRefreshHeader.h"
#import <CoreText/CoreText.h>

static CGFloat layer_width = 20;
static NSString *refreshing_animation_key = @"refreshingAnimation";
@implementation HCFunwearRefreshHeader {
    CALayer *_backgroundLayer;
    CAShapeLayer *_pathLayer;
    
    CALayer *_refreshingBgLayer;
    CAShapeLayer *_pathMaskLayer;
    CAShapeLayer *_refreshingShapeLayer;
}

- (void)prepare {
    [super prepare];
    _backgroundLayer = [CALayer layer];
    [self.layer addSublayer:_backgroundLayer];
    
    _refreshingBgLayer = [CALayer layer];
    _refreshingBgLayer.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1].CGColor;
    [self.layer addSublayer:_refreshingBgLayer];
}

- (void)placeSubviews {
    [super placeSubviews];
    _backgroundLayer.frame = self.bounds;
    _refreshingBgLayer.frame = self.bounds;
    [self setupTextLayer];
    [self startAnimation];
    
    [self setupRefreshingLayer];
//    [self refreshingAnimation];
    
    _refreshingBgLayer.mask = _pathMaskLayer;
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
//    NSLog(@"pullingPercent:%f",pullingPercent);
    if (pullingPercent == 0) {
        _pathLayer.timeOffset = 0;
    }
    else if ( pullingPercent > 0.5) {
        CGFloat fixPullingPercent =  (pullingPercent - 0.5)*20;
        CGFloat processValue =+ fixPullingPercent;
        _pathLayer.timeOffset = processValue;
//        NSLog(@"processValue:%f",processValue);
    }
    
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            /** 普通闲置状态 */
//            _pathLayer.timeOffset = 0;
            _refreshingBgLayer.hidden = YES;
            [_refreshingShapeLayer removeAllAnimations];
            break;
        case MJRefreshStatePulling:
            /** 松开就可以进行刷新的状态 */
//            _backgroundLayer.timeOffset = 10;
            break;
        case MJRefreshStateRefreshing:
            /** 正在刷新中的状态 */
            _backgroundLayer.timeOffset = 10;
            _refreshingBgLayer.hidden = NO;
            [self refreshingAnimation];
            //辉光 FUNWEAR
            break;
        case MJRefreshStateWillRefresh:
            /** 即将刷新的状态 */
//            _backgroundLayer.timeOffset = 10;
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
    if (_pathLayer != nil ) {
        [_pathLayer removeFromSuperlayer];
        _pathLayer = nil;
    }
    if (_pathMaskLayer != nil) {
        [_pathMaskLayer removeFromSuperlayer];
        _pathMaskLayer = nil;
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
    
    UIColor *grayColor = [UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:1];
    _pathLayer = [self shapeLayerWithPath:path strokeColor:grayColor];
    [_backgroundLayer addSublayer:_pathLayer];
    
    _pathLayer.speed = 0;
    _pathLayer.timeOffset = 0;
    
    UIColor *lessGrayColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
    _pathMaskLayer = [self shapeLayerWithPath:path strokeColor:lessGrayColor];
}
- (void)startAnimation
{
    [_pathLayer removeAllAnimations];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeBoth;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [_pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

- (CAShapeLayer *)shapeLayerWithPath:(UIBezierPath *)path strokeColor:(UIColor *)color {
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = _backgroundLayer.frame;
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = color.CGColor;
    // pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    return pathLayer;
}

- (void)setupRefreshingLayer {
    if (_refreshingShapeLayer) {
        return;
    }
    
    CGFloat start_x = _pathMaskLayer.position.x - CGRectGetWidth(_pathMaskLayer.bounds)/2.0 -layer_width*2;
    
    CGPoint left_top_point = CGPointMake(start_x, 0);
    CGPoint left_bottom_point = CGPointMake(start_x+layer_width, CGRectGetHeight(self.bounds));
    CGPoint right_top_point = CGPointMake(start_x+layer_width, 0);
    CGPoint right_bottom_point = CGPointMake(start_x+layer_width*2, CGRectGetHeight(self.bounds));
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:left_top_point];
    [path addLineToPoint:left_bottom_point];
    [path addLineToPoint:right_bottom_point];
    [path addLineToPoint:right_top_point];
    [path addLineToPoint:left_top_point];
    
    _refreshingShapeLayer = [CAShapeLayer layer];
    _refreshingShapeLayer.path = path.CGPath;
    _refreshingShapeLayer.fillColor = [UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:1].CGColor;
    _refreshingShapeLayer.lineWidth = 5;
    _refreshingShapeLayer.lineJoin = kCALineJoinRound;
    _refreshingShapeLayer.lineCap = kCALineCapRound;
    [_refreshingBgLayer addSublayer:_refreshingShapeLayer];
}

- (void)refreshingAnimation {
    if (!_refreshingShapeLayer) {
        [self setupRefreshingLayer];
    }
    
    CGFloat end_x = CGRectGetWidth(_pathMaskLayer.bounds)+layer_width*2;
    CABasicAnimation *refreshingAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    refreshingAnimation.fromValue = @(0);
    refreshingAnimation.toValue = @(end_x);
    refreshingAnimation.duration = 1.5;
    refreshingAnimation.repeatCount = HUGE;
    refreshingAnimation.removedOnCompletion = NO;
    refreshingAnimation.fillMode = kCAFillModeForwards;
    [_refreshingShapeLayer addAnimation:refreshingAnimation forKey:refreshing_animation_key];
}

@end
