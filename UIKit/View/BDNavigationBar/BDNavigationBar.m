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
#import "BDNavigationBar.h"
#import <QuartzCore/QuartzCore.h>

@interface BDNavigationBar ()
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation BDNavigationBar

static CGFloat const kDefaultOpacity = 0.5f;

- (void)setBarTintGradientColors:(NSArray *)barTintGradientColors
{
    // create the gradient layer
    if (self.gradientLayer == nil) {
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.opacity = self.translucent ? kDefaultOpacity : 1.0f;
    }
    
    NSMutableArray * colors = nil;
    if (barTintGradientColors != nil)
    {
        colors = [NSMutableArray arrayWithCapacity:[barTintGradientColors count]];
        
        // determine elements in the array are colours
        // and add them to the colors array
        [barTintGradientColors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIColor class]])
            {
                // UIColor class
                [colors addObject:(id)[obj CGColor]];
            }
            else if ( CFGetTypeID( (__bridge void *)obj ) == CGColorGetTypeID() )
            {
                // CGColorRef
                [colors addObject:obj];
            }
            else
            {
                // obj is not a supported type
                @throw [NSException exceptionWithName:@"BarTintGraidentColorsError" reason:@"object in barTintGradientColors array is not a UIColor or CGColorRef" userInfo:nil];
            }
        }];
        
        // make it possible for the graident to be seen for iOS 6 and iOS 7
        if ( [self respondsToSelector:@selector(setBarTintColor:)] )
        {
            // iOS 7
            self.barTintColor = [UIColor clearColor];
        }
        else
        {
            // iOS 6
            self.tintColor = [UIColor clearColor];
            // stops the gradient on iOS 6 UINavigationBar
            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        }
    }
    
    // set the graident colours to the laery
    self.gradientLayer.colors = colors;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // allow all layout subviews call to adjust the frame
    if ( self.gradientLayer != nil )
    {
        if ( floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 )
        {
            // iOS 7
            CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            self.gradientLayer.frame = CGRectMake(0, 0 - statusBarHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + statusBarHeight);
        }
        else
        {
            // iOS 6
            self.gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        }
        
        // make sure the graident layer is at position 1
        [self.layer insertSublayer:self.gradientLayer atIndex:1];
    }
}
@end
