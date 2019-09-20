//
//  YungLoadingClockAnimateView.m
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import "YungLoadingClockAnimateView.h"
#import "YungLoadingClockLineView.h"

@interface YungLoadingClockAnimateView ()

@property (nonatomic, strong) UIView *bgCircleView;

/** 时针
 */
@property (nonatomic, strong) YungLoadingClockLineView *hourLineView;

/** 分针
 */
@property (nonatomic, strong) YungLoadingClockLineView *minuteLineView;

/** 表框
 */
@property (nonatomic, strong) YungLoadingClockLineView *circleLineView;

@end

@implementation YungLoadingClockAnimateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bgCircleView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.bgCircleView];
        
        self.hourLineView = [[YungLoadingClockLineView alloc] initWithFrame:self.bounds lineType:YungLoadingClockLineViewTypeHour];
        [self.bgCircleView addSubview:self.hourLineView];
        
        self.minuteLineView = [[YungLoadingClockLineView alloc] initWithFrame:self.bounds lineType:YungLoadingClockLineViewTypeMinute];
        [self.bgCircleView addSubview:self.minuteLineView];
        
        self.circleLineView = [[YungLoadingClockLineView alloc] initWithFrame:self.bounds lineType:YungLoadingClockLineViewTypeCircle];
        [self.bgCircleView addSubview:self.circleLineView];
    }
    return self;
}

#pragma mark - public

/** 设置线条颜色
 */
- (void)setRefreshColor:(UIColor *)color {
    [self.hourLineView setRefreshColor:color];
    [self.minuteLineView setRefreshColor:color];
    [self.circleLineView setRefreshColor:color];
}

- (void)startAnimate {
    [self handleStartAnimate];
}

- (void)stopAnimate {
    [self handleStopAnimate];
}

#pragma mark - private

/** 开始loading动画
 */
- (void)handleStartAnimate {
    /******************************    分针旋转    ******************************/
    [CATransaction begin];
    [CATransaction setAnimationDuration:YungLoadingClockAnimateViewAnimateSpeed];
    //创建一个kCAMediaTimingFunctionLinear的匀速计时函数,设置其他类型可以先快后慢、先慢后快、先慢后慢等效果
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    NSString *rotationAnimateKey = @"rotationAnimateKey";
    CABasicAnimation *rotationAnimate = [self.minuteLineView.layer animationForKey:rotationAnimateKey];
    if (!rotationAnimate) {
        //设置 bgCircleView 的transform.rotation.z旋转360度;
        id value = [self.minuteLineView.layer valueForKeyPath:@"transform.rotation.z"];
        NSNumber *toValue = [NSNumber numberWithFloat:M_PI * 2];
        if ([value isKindOfClass:[NSNumber class]]) {
            //获取初始transform.rotation.z,再增加M_PI * 2
            toValue = [NSNumber numberWithFloat:[(NSNumber *)value floatValue] + M_PI * 2];
        }
        
        rotationAnimate = ({
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation.toValue = toValue;
            animation.repeatCount = HUGE_VALF;
            animation.removedOnCompletion = NO; //进入后台时,依然在动画,yes会造成切换后台重进后会动画停止
            animation;
        });
        [self.minuteLineView.layer addAnimation:rotationAnimate forKey:rotationAnimateKey];
    }
    
    [CATransaction commit];
    /************************************************************/
    
    /******************************    时针旋转    ******************************/
    [CATransaction begin];
    [CATransaction setAnimationDuration:YungLoadingClockAnimateViewAnimateSpeed*12];
    //创建一个kCAMediaTimingFunctionLinear的匀速计时函数,设置其他类型可以先快后慢、先慢后快、先慢后慢等效果
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    rotationAnimate = [self.hourLineView.layer animationForKey:rotationAnimateKey];
    if (!rotationAnimate) {
        //设置 bgCircleView 的transform.rotation.z旋转360度;
        id value = [self.hourLineView.layer valueForKeyPath:@"transform.rotation.z"];
        NSNumber *toValue = [NSNumber numberWithFloat:M_PI * 2];
        if ([value isKindOfClass:[NSNumber class]]) {
            //获取初始transform.rotation.z,再增加M_PI * 2
            toValue = [NSNumber numberWithFloat:[(NSNumber *)value floatValue] + M_PI * 2];
        }
        
        rotationAnimate = ({
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation.toValue = toValue;
            animation.repeatCount = HUGE_VALF;
            animation.removedOnCompletion = NO; //进入后台时,依然在动画,yes会造成切换后台重进后会动画停止
            animation;
        });
        [self.hourLineView.layer addAnimation:rotationAnimate forKey:rotationAnimateKey];
    }
    
    [CATransaction commit];
    /************************************************************/
}

/** 结束loading动画
 */
- (void)handleStopAnimate {
    NSString *rotationAnimateKey = @"rotationAnimateKey";
    [self.hourLineView.layer removeAnimationForKey:rotationAnimateKey];
    [self.minuteLineView.layer removeAnimationForKey:rotationAnimateKey];
}

@end
