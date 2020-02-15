/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "BDAnimation.h"
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface BDAnimation ()<CAAnimationDelegate>
@property (nonatomic, strong) CALayer *layer;
@end

@implementation BDAnimation

+(instancetype)shared
{
    static dispatch_once_t onceToken;
    static BDAnimation *a = nil;
    dispatch_once(&onceToken, ^{
        a = [[BDAnimation alloc]init];
    });
    return a;
}

- (void)moveView:(UIView *)fromView toView:(UIView *)toView controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2 imgView:(UIImageView *)imgView completion:(AnimationConpletionBlock)completion
{
    self.completionBlock = completion;
    
    _layer = [CALayer layer];
    _layer.contents = imgView.layer.contents;
    _layer.contentsGravity = kCAGravityResizeAspectFill;
    _layer.bounds = CGRectMake(CGRectGetMinX(fromView.frame) +30, CGRectGetMinY(fromView.frame), 40, 40);
    //    _layer.backgroundColor = [UIColor redColor].CGColor;
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:_layer];
    
    //    获取fromView在self.view上的位置
    CGRect fromViewRect = [fromView convertRect:fromView.bounds toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //    初始点fromView的中心
    [path moveToPoint:CGPointMake(fromViewRect.origin.x +fromViewRect.size.width /2, fromViewRect.origin.y +fromViewRect.size.height /2)];
    
    //    获取toView在self.view上的位置
    CGRect toViewRect = [toView convertRect:toView.bounds toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    
    //    增加一条曲线（终点是toView的）
    [path addCurveToPoint:CGPointMake(toViewRect.origin.x +toViewRect.size.width /2, toViewRect.origin.y +toViewRect.size.height /2)
            controlPoint1:(controlPoint1.x == 0 && controlPoint1.y == 0) ? CGPointMake(CGRectGetMinX(fromView.frame) +150, SCREEN_HEIGHT -CGRectGetHeight(fromView.frame) -100) : controlPoint1
            controlPoint2:(controlPoint2.x == 0 && controlPoint2.y == 0) ? CGPointMake(CGRectGetMinX(fromView.frame) +150, SCREEN_HEIGHT -CGRectGetHeight(fromView.frame) -200) : controlPoint2];
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    
    //    缩小动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.removedOnCompletion = YES;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.5];
    
    //    执行
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation,scaleAnimation];
    groups.duration = 0.5f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
}

- (void)shootOutView:(UIView *)view
{
    CGRect frame = view.frame;
    [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^(void){
        
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void){
            //弹起
            view.frame = CGRectMake(frame.origin.x, frame.origin.y-20, frame.size.width, frame.size.height);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^(void){
                //下降
                view.frame = frame;
            } completion:^(BOOL finished){
                [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                    //弹起
                    view.frame = CGRectMake(frame.origin.x, frame.origin.y-10, frame.size.width, frame.size.height);
                } completion:^(BOOL finished){
                    //下降
                    [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                        view.frame = frame;
                    } completion:^(BOOL finished){
                    }];
                }];
            }];
        }];
    }];
}

- (void)bigAndSmallView:(UIView *)view repeatCount:(float)rCount duration:(float)duration pathValues:(NSArray *)values
{
    [view.layer removeAllAnimations];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.repeatCount = rCount;
    animation.duration = duration;// 动画时间
    if (values) {
        animation.values = values;
    }else{
        NSMutableArray *vl = [NSMutableArray array];
        [vl addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [vl addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
        [vl addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
        [vl addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)]];
        [vl addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
        [vl addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
        [vl addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = vl;
    }
    [view.layer addAnimation:animation forKey:@"shake"];
}

- (void)rotateView:(UIView *)view clockwise:(BOOL)clockwise repeatCount:(float)rCount duration:(float)duration
{
    [view.layer removeAllAnimations];
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*(clockwise?2.0:-2.0)];//逆时针
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = rCount;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark - CAAnimationDelegate

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    if (anim == [_layer animationForKey:@"group"]) {
        [_layer removeFromSuperlayer];
        _layer = nil;
        
        if (self.completionBlock) {
            self.completionBlock();
        }
//    }
}

@end
