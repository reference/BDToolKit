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
#import <UIKit/UIKit.h>

@class APParallaxView;
@class APParallaxShadowView;

#pragma mark UIScrollView Category

@interface UIScrollView (APParallaxHeader)

- (void)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height andShadow:(BOOL)shadow;
- (void)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height;
- (void)addParallaxWithView:(UIView*)view andHeight:(CGFloat)height;
- (void)addParallaxWithView:(UIView*)view andHeight:(CGFloat)height andShadow:(BOOL)shadow;

@property (nonatomic, strong, readonly) APParallaxView *parallaxView;
@property (nonatomic, assign) BOOL showsParallax;

@end

#pragma mark APParallaxView

@protocol APParallaxViewDelegate;

typedef NS_ENUM(NSUInteger, APParallaxTrackingState) {
    APParallaxTrackingActive = 0,
    APParallaxTrackingInactive
};

@interface APParallaxView : UIView

@property (weak) id<APParallaxViewDelegate> delegate;

@property (nonatomic, readonly) APParallaxTrackingState state;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *currentSubView;
@property (nonatomic, strong) APParallaxShadowView *shadowView;
@property (nonatomic, strong) UIView *customView;

- (id)initWithFrame:(CGRect)frame andShadow:(BOOL)shadow;

@end

@protocol APParallaxViewDelegate <NSObject>
@optional
- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame;
- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame;
@end

#pragma mark APParallaxShadowView

@interface APParallaxShadowView : UIView

@end
