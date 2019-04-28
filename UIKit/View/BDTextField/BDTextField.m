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
#import <Foundation/Foundation.h>
#import "BDTextField.h"
#define DefaultSize 13

@interface BDTextField()

@end

@implementation BDTextField

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    if (!self.iconImageView) {
        self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
        [self addSubview:self.iconImageView];
    }
    self.iconImageView.image = [UIImage imageNamed:icon];
}

- (void)setIconSize:(CGFloat)iconSize
{
    _iconSize = iconSize;
    [self sizeToFit];
}

- (void)drawRect:(CGRect)rect
{
    if (!self.iconImageView) {
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.iconImageView];
    }
    if (!self.textField) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
        [self addSubview:self.textField];
    }
    
    CGFloat realSize = self.iconSize>0?self.iconSize:DefaultSize;
    self.iconImageView.frame = CGRectMake(10, rect.size.height/2.f-realSize/2.f, realSize, realSize);
    
    self.textField.frame = CGRectMake(10 + realSize + self.iconImageView.origin.x,
                                      0, rect.size.width - 10*2 - self.iconImageView.frame.origin.x, rect.size.height);
}
@end
