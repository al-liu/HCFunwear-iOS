//
//  HCCirculateScrollView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/23.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCCirculateScrollView.h"
#import "UIImageView+HCPackWebImage.h"
#import "GlobalConstant.h"

static NSInteger const kDescriptionTime = 2;

@interface HCCirculateScrollView () <UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    NSTimer *timer;
    NSMutableArray * imageUrlList;
    CGFloat viewWidth;
    CGFloat viewHeight;
    int pageCount;
    
    NSArray *originURLStringList;
}

@end

@implementation HCCirculateScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.contentMode = UIViewContentModeCenter;
        _isAutomatic = NO;
        viewWidth = CGRectGetWidth(frame);
        viewHeight = CGRectGetHeight(frame);
        pageCount = 2;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (viewWidth == 0 && viewHeight == 0) {
        viewWidth = CGRectGetWidth(self.frame);
        viewHeight = CGRectGetHeight(self.frame);
        if (viewWidth == 0 && viewHeight == 0) {
            return;
        }
        [self loadView:originURLStringList];
    }
}

- (void)loadView:(NSArray *)imageUrlStrings {
    originURLStringList = imageUrlStrings;
    if (viewWidth == 0 && viewHeight == 0) {
        return;
    }
    if (imageUrlStrings.count == 0) {
        return;
    }
    else if (imageUrlStrings.count == 1) {
        NSURL * url = nil;
        if ([imageUrlStrings.firstObject isKindOfClass:[NSString class]]) {
            url = [[NSURL alloc]initWithString:imageUrlStrings.firstObject];
        }
        else if ([imageUrlStrings.firstObject isKindOfClass:[NSURL class]]) {
            url = imageUrlStrings.firstObject;
        }
        [self loadImageOfProtocolWithURL:url imageView:self];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selecedAdvert:)];
        self.tag = -1;
        [self addGestureRecognizer:tap];
    }
    
    NSMutableArray * urlList = [[NSMutableArray alloc]initWithArray:imageUrlStrings];
    [urlList insertObject:imageUrlStrings.lastObject atIndex:0];
    [urlList addObject:imageUrlStrings.firstObject];
    
    imageUrlList = [[NSMutableArray alloc]initWithCapacity:urlList.count];
    [urlList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSURL * url = [[NSURL alloc]initWithString:obj];
            [imageUrlList addObject:url];
        }
        else if ([obj isKindOfClass:[NSURL class]]) {
            [imageUrlList addObject:obj];
        }
    }];
    
    if (_scrollView != nil) {
        [_scrollView removeFromSuperview];
    }
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
//    _scrollView.backgroundColor = [UIColor greenColor];
    _scrollView.contentSize = CGSizeMake(viewWidth * imageUrlList.count, viewHeight);

    [_scrollView setContentOffset:CGPointMake(viewWidth, 0)];
    [self pageControlOfProtocolWithIndex:0];
    
    [self addSubview:_scrollView];
    
    for (int i = 0; i < imageUrlList.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth * i, 0, viewWidth, viewHeight)];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selecedAdvert:)];
        [imageView addGestureRecognizer:tap];
        
        if (i == 0) {
            imageView.tag = imageUrlStrings.count-1;
        }
        else if (i == imageUrlList.count -1) {
            imageView.tag = 0;
        }
        else {
            imageView.tag = i-1;
        }
        [self loadImageOfProtocolWithURL:imageUrlList[i] imageView:imageView];
    }
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    if (placeholderImage) {
        self.image = placeholderImage;
    }
}

- (void)setIsAutomatic:(BOOL)isAutomatic {
    _isAutomatic = isAutomatic;
    if (_isAutomatic == YES) {
        if (timer) {
            [timer invalidate];
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:kDescriptionTime target:self selector:@selector(autoRollAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    else {
        [timer invalidate];
    }
}

- (void)autoRollAction {
    [_scrollView setContentOffset:CGPointMake(pageCount * viewWidth, 0) animated:YES];
    pageCount += 1;
    if (pageCount == imageUrlList.count) {
        pageCount = 2;
    }
}

- (void)selecedAdvert:(UITapGestureRecognizer *)tap {
    UIImageView * imageView = (UIImageView *)tap.view;
    NSInteger index = imageView.tag;
    [self didSelectedViewOfProtocolWithIndex:index];
}

- (void)updateScrollOffSize {
    if (_scrollView.contentOffset.x == viewWidth * (imageUrlList.count - 1)) {
        [_scrollView setContentOffset:CGPointMake(viewWidth, 0) animated:NO];
    }
    else if (_scrollView.contentOffset.x == 0) {
        [_scrollView setContentOffset:CGPointMake(viewWidth * (imageUrlList.count - 2), 0) animated:NO];
    }
}

#pragma mark - HCCirculateScrollViewProtocol
- (void)loadImageOfProtocolWithURL:(NSURL *)url imageView:(UIImageView *)view {
    if (_delegate) {
        if ([_delegate conformsToProtocol:@protocol(HCCirculateScrollViewProtocol)] && [_delegate respondsToSelector:@selector(circulateScrollView:loadImageUrl:withImageView:)]) {
            [_delegate circulateScrollView:self loadImageUrl:url withImageView:view];
        }
        else {
            [view packAspectFillModeSetImageWithURL:url placeholder:defaultImage02];
        }
    }
    else {
        [view packAspectFillModeSetImageWithURL:url placeholder:defaultImage02];
    }
}
- (void)didSelectedViewOfProtocolWithIndex:(NSInteger)index {
    if (_delegate) {
        if ([_delegate conformsToProtocol:@protocol(HCCirculateScrollViewProtocol)] && [_delegate respondsToSelector:@selector(circulateScrollViewDidSelectedAtIndex:)]) {
            [_delegate circulateScrollViewDidSelectedAtIndex:index];
        }
    }
}
- (void)pageControlOfProtocolWithIndex:(NSInteger)index {
    if (_delegate) {
        if ([_delegate conformsToProtocol:@protocol(HCCirculateScrollViewProtocol)] && [_delegate respondsToSelector:@selector(circulateScrollViewPageControlAtIndex:)]) {
            [_delegate circulateScrollViewPageControlAtIndex:index];
        }
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isAutomatic) {
        [self updateScrollOffSize];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateScrollOffSize];
    
    NSInteger currentPageNumber = scrollView.contentOffset.x / viewWidth;
    pageCount = (int)currentPageNumber;
    
    if (currentPageNumber == imageUrlList.count-1) {
        currentPageNumber = 0;
    }
    else if (currentPageNumber == 0) {
        currentPageNumber = imageUrlList.count-3;
    }
    else {
        currentPageNumber = currentPageNumber-1;
    }
    
    [self pageControlOfProtocolWithIndex:currentPageNumber];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
