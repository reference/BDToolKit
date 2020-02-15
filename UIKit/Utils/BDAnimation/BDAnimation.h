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

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^AnimationConpletionBlock)(void);

@interface BDAnimation : NSObject
@property (nonatomic,copy) AnimationConpletionBlock completionBlock;

+(instancetype)shared;

/// Move view from to
/// @param fromView from view
/// @param toView to view
/// @param controlPoint1 bezier path point 1 
/// @param controlPoint2 bezier path point 2
/// @param imgView img
/// @param completion animationCompletion
- (void)moveView:(UIView *)fromView toView:(UIView *)toView controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2 imgView:(UIImageView *)imgView completion:(AnimationConpletionBlock)completion;

/// Move up and down in
/// @param view view
- (void)shootOutView:(UIView *)view;

/// turn the view big and small
/// @param view  view
/// @param values  path values
- (void)bigAndSmallView:(UIView *)view repeatCount:(float)rCount duration:(float)duration pathValues:(NSArray *)values;

/// Rotate the view
/// @param view view
/// @param clockwise DEFAULT NO
/// @param rCount rcount
/// @param duration duration
- (void)rotateView:(UIView *)view clockwise:(BOOL)clockwise repeatCount:(float)rCount duration:(float)duration;
@end

NS_ASSUME_NONNULL_END
