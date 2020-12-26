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
#import <UIKit/UIKit.h>
#import <pop/POP.h>

@class BDPOPNumberAnimation;

@protocol BDPOPNumberAnimationDelegate <NSObject>

@required

/**
 *  When you run 'startAnimation' method, this delegate method will get current value for you in real time.
 *
 *  @param numberAnimation BDPOPNumberAnimation object.
 *  @param currentValue    Current value in real time.
 */
- (void)BDPOPNumberAnimation:(BDPOPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue;

@end

@interface BDPOPNumberAnimation : NSObject

@property (nonatomic, weak) id <BDPOPNumberAnimationDelegate>  delegate;

/**
 * Animation callback method
 */
@property (nonatomic, copy) void (^animationCallback) (BDPOPNumberAnimation *numberAnimation,CGFloat currentValue);

/**
 *  Animation's start value.
 */
@property (nonatomic)       CGFloat                          fromValue;

/**
 *  Animation's destination value.
 */
@property (nonatomic)       CGFloat                          toValue;

/**
 *  Current value.
 */
@property (nonatomic)       CGFloat                          currentValue;

/**
 *  Animation's duration, default value is 0.4s.
 */
@property (nonatomic)       NSTimeInterval                   duration;

/**
 *  Animation's timingFunction.
 */
@property (nonatomic, strong) CAMediaTimingFunction         *timingFunction;

/**
 *  When you have set all propeties, you must save values to make the config effect.
 */
- (void)saveValues;

/*
 *  Before you run this method, you should make sure save values to make the config effect.
 */
- (void)startAnimation;

/*
 *  Stop animation.
 */
- (void)stopAnimation;

@end
