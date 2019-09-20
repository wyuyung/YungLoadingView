//
//  YungLoadingCircleLineView.m
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import "YungLoadingCircleLineView.h"
//#import <QuartzCore/QuartzCore.h>

@interface YungLoadingCircleLineView ()


@end

@implementation YungLoadingCircleLineView

- (void)setRefreshColor:(UIColor *)color {
    [self.shapeLayer setStrokeColor:color.CGColor];
}

- (id)initWithFrame:(CGRect)frame isTop:(BOOL)top {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        CAShapeLayer *sLayer = [CAShapeLayer layer];
        self.shapeLayer = sLayer;
        
        CGFloat lineWidth = 2;
        
        if (top) {
            self.shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)
                                                             radius:(CGRectGetWidth(self.frame) - lineWidth - 2) / 2
                                                         startAngle:M_PI / 6.
                                                           endAngle:M_PI * 13 / 12.
                                                          clockwise:NO].CGPath;
        } else {
            self.shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)
                                                             radius:(CGRectGetWidth(self.frame) - lineWidth - 2) / 2
                                                         startAngle:M_PI / 12.
                                                           endAngle:M_PI * 14 / 12.
                                                          clockwise:YES].CGPath;
        }
        
        self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
        self.shapeLayer.strokeStart = .499;
        self.shapeLayer.strokeEnd = .501;
        self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        self.shapeLayer.lineWidth = 1;
        self.shapeLayer.lineCap = @"round";
        self.shapeLayer.lineJoin = @"round";
        
        [self.layer addSublayer:self.shapeLayer];
    }
    
    return self;
}

@end
