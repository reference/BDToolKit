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
#import "UIButton+Layout.h"
#import <objc/runtime.h>

@implementation UIButton(Layout)

- (void)setTitleImageLayout:(NSInteger)layout
{
    objc_setAssociatedObject(self, @selector(titleImageLayout), @(layout), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layoutTitleImage];
}

- (NSInteger)titleImageLayout
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(titleImageLayout));
    return [number integerValue];
}

- (void)setTitleImageSpacing:(CGFloat)titleImageSpacing {
    objc_setAssociatedObject(self, @selector(titleImageSpacing), @(titleImageSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layoutTitleImage];
}

- (CGFloat)titleImageSpacing {
    NSNumber *number = objc_getAssociatedObject(self, @selector(titleImageSpacing));
    return [number floatValue];
}

- (void)layoutTitleImage {
    // reset
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    [self layoutIfNeeded];
    // frame
    CGRect title = self.titleLabel.frame;
    CGRect image = self.imageView.frame;
    CGFloat space = self.titleImageSpacing / 2;
    CGPoint point = CGPointZero;
    // layout
    switch (self.titleImageLayout) {
        case ButtonTitleImageLayoutLeft:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, space, 0, 0)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
            break;
        }
        case ButtonTitleImageLayoutRight:
        {
            point.x = title.origin.x - image.origin.x + space;
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -point.x, 0, point.x)];
            point.x = title.size.width + space;
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, point.x, 0, -point.x)];
            break;
        }
        case ButtonTitleImageLayoutTop:
        {
            point.x = image.size.width;
            point.y = image.size.height + space;
            [self setTitleEdgeInsets:UIEdgeInsetsMake(point.y, -point.x, 0, 0)];
            point.x = title.size.width;
            point.y = title.size.height + space;
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, point.y, -point.x)];
            break;
        }
        case ButtonTitleImageLayoutBottom:
        {
            point.x = image.size.width;
            point.y = image.size.height + space;
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-point.y, -point.x, 0, 0)];
            point.x = title.size.width;
            point.y = title.size.height + space;
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -point.y, -point.x)];
            break;
        }
    }
}


@end
