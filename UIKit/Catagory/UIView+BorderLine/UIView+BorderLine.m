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
#import "UIView+BorderLine.h"
#import "NSObject+Identifier.h"

static NSString * const kLineLeft = @"kLineLeft__";
static NSString * const kLineRight = @"kLineRight__";
static NSString * const kLineTop = @"kLineTop__";
static NSString * const kLineBottom = @"kLineBottom__";

@implementation UIView(BorderLine)
//common
- (CALayer *)layerForIdentifier:(NSString *)identifier
{
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.identifier isEqualToString:identifier]) {
            return layer;
        }
    }
    return nil;
}

#pragma mark - 边框线条
//left
- (void)setLeftLineWidth:(CGFloat)leftLineWidth
{
    CALayer *layer = [self layerForIdentifier:kLineLeft];
    if (!layer) {
        layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
    }
    CGRect rect = CGRectMake(0, 0, leftLineWidth, self.bounds.size.height);
    layer.frame = rect;
}

- (CGFloat)leftLineWidth
{
    CALayer *layer = [self layerForIdentifier:kLineLeft];
    return layer ? layer.frame.size.width : 0;
}

//right
- (void)setRightLineWidth:(CGFloat)rightLineWidth
{
    CALayer *layer = [self layerForIdentifier:kLineRight];
    if (!layer) {
        layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
    }
    CGRect rect = CGRectMake(0, 0, rightLineWidth, self.bounds.size.height);
    layer.frame = rect;
}

- (CGFloat)rightLineWidth
{
    CALayer *layer = [self layerForIdentifier:kLineRight];
    return layer ? layer.frame.size.width : 0;
}

//top
- (void)setTopLineHeight:(CGFloat)topLineHeight
{
    CALayer *layer = [self layerForIdentifier:kLineTop];
    if (!layer) {
        layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
    }
    CGRect rect = CGRectMake(0, 0, topLineHeight, self.bounds.size.height);
    layer.frame = rect;
}

- (CGFloat)topLineHeight
{
    CALayer *layer = [self layerForIdentifier:kLineTop];
    return layer ? layer.frame.size.width : 0;
}

//bottom
- (void)setBottomLineHeight:(CGFloat)bottomLineHeight
{
    CALayer *layer = [self layerForIdentifier:kLineBottom];
    if (!layer) {
        layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
    }
    CGRect rect = CGRectMake(0, 0, bottomLineHeight, self.bounds.size.height);
    layer.frame = rect;
}

- (CGFloat)bottomLineHeight
{
    CALayer *layer = [self layerForIdentifier:kLineBottom];
    return layer ? layer.frame.size.width : 0;
}

#pragma mark - 边框颜色

//left
- (void)setLeftLineColor:(UIColor *)leftLineColor
{
    CALayer *layer = [self layerForIdentifier:kLineLeft];
    if (!layer) {
        layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
    }
    layer.backgroundColor = leftLineColor.CGColor;
}

- (UIColor *)leftLineColor
{
    CALayer *layer = [self layerForIdentifier:kLineLeft];
    return layer ? [UIColor colorWithCGColor:layer.backgroundColor] : nil;
}

//right
- (void)setRightLineColor:(UIColor *)rightLineColor
{
    CALayer *layer = [self layerForIdentifier:kLineRight];
    if (!layer) {
        layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
    }
    layer.backgroundColor = rightLineColor.CGColor;
}

- (UIColor *)rightLineColor
{
    CALayer *layer = [self layerForIdentifier:kLineRight];
    return layer ? [UIColor colorWithCGColor:layer.backgroundColor] : nil;
}

//top
- (void)setTopLineColor:(UIColor *)topLineColor
{
    CALayer *layer = [self layerForIdentifier:kLineTop];
    if (!layer) {
        layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
    }
    layer.backgroundColor = topLineColor.CGColor;
}

- (UIColor *)topLineColor
{
    CALayer *layer = [self layerForIdentifier:kLineTop];
    return layer ? [UIColor colorWithCGColor:layer.backgroundColor] : nil;
}

//bottom
- (void)setBottomLineColor:(UIColor *)bottomLineColor
{
    CALayer *layer = [self layerForIdentifier:kLineBottom];
    if (!layer) {
        layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
    }
    layer.backgroundColor = bottomLineColor.CGColor;
}

- (UIColor *)bottomLineColor
{
    CALayer *layer = [self layerForIdentifier:kLineBottom];
    return layer ? [UIColor colorWithCGColor:layer.backgroundColor] : nil;
}
@end
