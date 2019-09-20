//
//  YungLoadingCircleAnimateView.m
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import "YungLoadingCircleAnimateView.h"
#import "YungLoadingCircleLineView.h"

@interface YungLoadingCircleAnimateView ()

@property (nonatomic, strong) UIView *bgCircleView;
@property (nonatomic, strong) YungLoadingCircleLineView *inCircleView;
@property (nonatomic, strong) YungLoadingCircleLineView *outCircleView;

@end

@implementation YungLoadingCircleAnimateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bgCircleView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.bgCircleView];
        
        self.outCircleView = [[YungLoadingCircleLineView alloc] initWithFrame:self.bounds isTop:YES];
        [self.bgCircleView addSubview:self.outCircleView];
        
        self.inCircleView = [[YungLoadingCircleLineView alloc] initWithFrame:(CGRect){4, 4, CGRectGetWidth(self.frame) - 8, CGRectGetHeight(self.frame) - 8} isTop:NO];
        [self.inCircleView setRefreshColor:[UIColor greenColor]];
        [self.bgCircleView addSubview:self.inCircleView];
    }
    return self;
}

#pragma mark - public

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
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.2];
    //创建一个kCAMediaTimingFunctionLinear的匀速计时函数,设置其他类型可以先快后慢、先慢后快、先慢后慢等效果
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    NSString *rotationAnimateKey = @"rotationAnimateKey";
    CABasicAnimation *rotationAnimate = [self.bgCircleView.layer animationForKey:rotationAnimateKey];
    NSLog(@"anchorPoint: %@",NSStringFromCGPoint(self.bgCircleView.layer.anchorPoint));
    if (!rotationAnimate) {
        //设置 bgCircleView 的transform.rotation.z旋转360度;
        id value = [self.bgCircleView.layer valueForKeyPath:@"transform.rotation.z"];
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
        [self.bgCircleView.layer addAnimation:rotationAnimate forKey:rotationAnimateKey];
    }
    
    //线段开始位置
    NSString *strokeStartAnimationKey = @"strokeStartAnimationKey";
    CABasicAnimation *strokeStartAnimation = [self.inCircleView.shapeLayer animationForKey:strokeStartAnimationKey];
    if (!strokeStartAnimation) {
        strokeStartAnimation = ({
            //里层线段 strokeStart 位置从0~0.49不断来回,从而实现线段开始位置不断变化
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
            animation.toValue = @(0.);
            animation.autoreverses = YES;
            animation.repeatCount = HUGE_VALF;
            animation.removedOnCompletion = NO; //进入后台时,依然在动画,yes会造成切换后台重进后会动画停止
            animation;
        });
        [self.inCircleView.shapeLayer addAnimation:strokeStartAnimation forKey:strokeStartAnimationKey];
    }
    strokeStartAnimation = [self.outCircleView.shapeLayer animationForKey:strokeStartAnimationKey];
    if (!strokeStartAnimation) {
        strokeStartAnimation = ({
            //外层线段 strokeStart 位置从0~0.49不断来回,从而实现线段开始位置不断变化
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
            animation.toValue = @(0.);
            animation.autoreverses = YES;
            animation.repeatCount = HUGE_VALF;
            animation.removedOnCompletion = NO; //进入后台时,依然在动画,yes会造成切换后台重进后会动画停止
            animation;
        });
        [self.outCircleView.shapeLayer addAnimation:strokeStartAnimation forKey:strokeStartAnimationKey];
    }

    //线段结束位置
    NSString *strokeEndAnimationKey = @"strokeEndAnimationKey";
    CABasicAnimation *strokeEndAnimation = [self.inCircleView.shapeLayer animationForKey:strokeEndAnimationKey];
    if (!strokeEndAnimation) {
        strokeEndAnimation = ({
            //里层线段 strokeEnd 位置从1~0.51不断来回,从而实现线段开始位置不断变化
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.toValue = @(1.);
            animation.autoreverses = YES;
            animation.repeatCount = HUGE_VALF;
            animation.removedOnCompletion = NO; //进入后台时,依然在动画,yes会造成切换后台重进后会动画停止
            animation;
        });
        [self.inCircleView.shapeLayer addAnimation:strokeEndAnimation forKey:strokeEndAnimationKey];
    }

    strokeEndAnimation = [self.outCircleView.shapeLayer animationForKey:strokeEndAnimationKey];
    if (!strokeEndAnimation) {
        strokeEndAnimation = ({
            //里层线段 strokeEnd 位置从1~0.51不断来回,从而实现线段开始位置不断变化
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.toValue = @(1);
            animation.autoreverses = YES;
            animation.repeatCount = HUGE_VALF;
            animation.removedOnCompletion = NO; //进入后台时,依然在动画,yes会造成切换后台重进后会动画停止
            animation;
        });
        [self.outCircleView.shapeLayer addAnimation:strokeEndAnimation forKey:strokeEndAnimationKey];
    }
    
    [CATransaction commit];
}

/** 结束loading动画
 */
- (void)handleStopAnimate {
    [self.inCircleView.shapeLayer removeAllAnimations];
    [self.outCircleView.shapeLayer removeAllAnimations];
    [self.bgCircleView.layer removeAnimationForKey:@"rotationAnimateKey"];
}

@end
