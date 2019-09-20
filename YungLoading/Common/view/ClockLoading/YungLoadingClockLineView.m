//
//  YungLoadingClockLineView.m
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import "YungLoadingClockLineView.h"

@implementation YungLoadingClockLineView

- (void)setRefreshColor:(UIColor *)color {
    [self.shapeLayer setStrokeColor:color.CGColor];
}

- (id)initWithFrame:(CGRect)frame lineType:(YungLoadingClockLineViewType)type; {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        CAShapeLayer *sLayer = [CAShapeLayer layer];
        self.shapeLayer = sLayer;
        
        CGFloat lineWidth = 1;
        
        switch (type) {
            case YungLoadingClockLineViewTypeHour: {
                //时针
                UIBezierPath *bezierPath = [UIBezierPath bezierPath];
                [bezierPath addArcWithCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2) radius:1 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
                [bezierPath moveToPoint:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)];
                [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 4)];
                self.shapeLayer.path = bezierPath.CGPath;
                break;
            }
            case YungLoadingClockLineViewTypeMinute: {
                //分针
                UIBezierPath *bezierPath = [UIBezierPath bezierPath];
                [bezierPath addArcWithCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2) radius:1 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
                [bezierPath moveToPoint:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)];
                [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 10)];
                self.shapeLayer.path = bezierPath.CGPath;
                break;
            }
            case YungLoadingClockLineViewTypeCircle: {
                //最外圈半径
                float radius = (CGRectGetWidth(self.frame) - lineWidth - 2) / 2;
                //小刻度内圈半径
                float smallInRadius = radius - 1.;
                //大刻度内圈半径
                float bigInRadius = radius - 2.;
                
                //直接圆圈表框
//                self.shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)
//                                                                      radius:radius
//                                                                  startAngle:0.
//                                                                    endAngle:M_PI * 2
//                                                                   clockwise:NO].CGPath;
                
                UIBezierPath *bezierPath = [UIBezierPath bezierPath];
                for (int i = 0; i < 60; i++) {
                    //圆心位置
                    CGPoint arcCenter = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
                    float angle = i / 30. * M_PI;
                    float cosAngle = cos(angle);
                    float sinAngle = sin(angle);
                    //外圈位置
                    float outX = arcCenter.x + radius * cosAngle;
                    float outY = arcCenter.y - radius * sinAngle;
                    //内圈位置
                    float inX;
                    float inY;
                    if (i % 5 == 0) {
                        //1,2,~12点位置,线比较长,凸出点位
                        inX = arcCenter.x + bigInRadius * cosAngle;
                        inY = arcCenter.y - bigInRadius * sinAngle;
                    } else {
                        inX = arcCenter.x + smallInRadius * cosAngle;
                        inY = arcCenter.y - smallInRadius * sinAngle;
                    }
                    
                    //描绘表框点位
                    [bezierPath moveToPoint:CGPointMake(inX, inY)];
                    [bezierPath addLineToPoint:CGPointMake(outX, outY)];
                }
                
                lineWidth = 0.7;
                self.shapeLayer.path = bezierPath.CGPath;
                break;
            }
            default:
                break;
        }
        
        self.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        self.shapeLayer.lineWidth = lineWidth;
        //线的端点做圆滑round处理
        self.shapeLayer.lineCap = @"round";
        //线的交点做圆滑round处理
        self.shapeLayer.lineJoin = @"round";
        
        [self.layer addSublayer:self.shapeLayer];
    }
    
    return self;
}

@end
