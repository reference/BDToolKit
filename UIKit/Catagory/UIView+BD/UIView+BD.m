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

#import "UIView+BD.h"
#import <objc/runtime.h>

static const char *kGradientHexColors = "kGradientHexColors";
static const char *kGradientLocations = "kGradientLocations";

@implementation UIView(BD)

#pragma mark - setCornerRadius/borderWidth/borderColor
//- (void)setCornerRadius:(NSInteger)cornerRadius{
//    self.layer.cornerRadius = cornerRadius;
//    self.layer.masksToBounds = cornerRadius > 0;
//}
//
//- (NSInteger)cornerRadius{
//    return self.layer.cornerRadius;
//}
//
//- (void)setBorderWidth:(NSInteger)borderWidth{
//    self.layer.borderWidth = borderWidth;
//}
//
//- (NSInteger)borderWidth{
//    return self.layer.borderWidth;
//}
//
//- (void)setBorderColor:(UIColor *)borderColor{
//    self.layer.borderColor = borderColor.CGColor;
//}
//
//- (UIColor *)borderColor{
//    return [UIColor colorWithCGColor:self.layer.borderColor];
//}

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (NSArray *)gradientHexColors
{
    return objc_getAssociatedObject(self, kGradientHexColors);
}

- (void)setGradientHexColors:(NSArray *)gradientHexColors
{
    objc_setAssociatedObject(self,kGradientHexColors, gradientHexColors,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)gradientLocations
{
    return objc_getAssociatedObject(self, kGradientLocations);
}

- (void)setGradientLocations:(NSArray *)gradientLocations
{
    objc_setAssociatedObject(self,kGradientLocations, gradientLocations,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
