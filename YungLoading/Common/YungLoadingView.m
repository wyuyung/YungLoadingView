//
//  YungLoadingView.m
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import "YungLoadingView.h"
#import "YungLoadingCircleAnimateView.h"
#import "YungLoadingClockAnimateView.h"

@interface YungLoadingView ()

/** 黑色背景框
 */
@property(nonatomic, strong) UIView *loadingBgView;

/** 线圈循环旋转view
 */
@property(nonatomic, strong) YungLoadingCircleAnimateView *circleAnimateView;

/** 时针循环旋转view
 */
@property(nonatomic, strong) YungLoadingClockAnimateView *clockAnimateView;

@end

@implementation YungLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.loadingBgView = [[UIView alloc] initWithFrame:(CGRect){0, 0, 100, 80}];
        [self.loadingBgView.layer setCornerRadius:10];
        [self.loadingBgView setClipsToBounds:YES];
        [self.loadingBgView setBackgroundColor:[UIColor colorWithWhite:0. alpha:0.8]];
        [self addSubview:self.loadingBgView];
        
        self.clockAnimateView = [[YungLoadingClockAnimateView alloc] initWithFrame:(CGRect){0, 0, 40, 40}];
        [self.clockAnimateView setCenter:CGPointMake(CGRectGetWidth(self.loadingBgView.frame) * 0.5, CGRectGetHeight(self.loadingBgView.frame) * 0.5)];
        [self.clockAnimateView setRefreshColor:[UIColor whiteColor]];
        [self.loadingBgView addSubview:self.clockAnimateView];
    }
    return self;
}

+ (instancetype)createLoadingView {
    YungLoadingView *loadingView = [[YungLoadingView alloc] initWithFrame:(CGRect){0, 0, 200, 200}];
    return loadingView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.loadingBgView setCenter:CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5)];
}

- (void)showLoadingInView:(UIView *)view {
    [self setFrame:view.bounds];
    [view addSubview:self];
    
    //增加约束
//    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftLayoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    LeftLayoutConstraint.active = YES;
    NSLayoutConstraint *rightLayoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    rightLayoutConstraint.active = YES;
    
    
    [self.clockAnimateView startAnimate];
}

- (void)stopLoading {
    [self.clockAnimateView stopAnimate];
}

@end
