/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit BDButtonpersons to whom the Software is
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
#import "BDLabel.h"

@implementation BDLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.textInsets = UIEdgeInsetsMake(self.topEdge, self.leftEdge, self.bottomEdge, self.rightEdge);
        self.radius = 0;
        self.borderColor = [UIColor clearColor];
        self.borderWidth = 0;
    }return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.textInsets = UIEdgeInsetsMake(self.topEdge, self.leftEdge, self.bottomEdge, self.rightEdge);
        self.radius = 0;
        self.borderColor = [UIColor clearColor];
        self.borderWidth = 0;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textInsets = UIEdgeInsetsMake(self.topEdge, self.leftEdge, self.bottomEdge, self.rightEdge);
    }
    return self;
}

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = YES;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

// 文字区域
- (void)drawTextInRect:(CGRect)rect {
    self.textInsets = UIEdgeInsetsMake(self.topEdge, self.leftEdge, self.bottomEdge, self.rightEdge);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

// UILabel的内容区域
- (CGSize)intrinsicContentSize {
    self.textInsets = UIEdgeInsetsMake(self.topEdge, self.leftEdge, self.bottomEdge, self.rightEdge);
    CGSize size = [super intrinsicContentSize];
    size.width  += self.textInsets.left + self.textInsets.right;
    size.height += self.textInsets.top + self.textInsets.bottom;
    return size;
}


@end
