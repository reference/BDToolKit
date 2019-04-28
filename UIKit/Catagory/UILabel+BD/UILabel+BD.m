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
#import "UILabel+BD.h"

@implementation UILabel(BD)

- (void)setTextHexColor:(NSString *)textHexColor{
    NSScanner *scanner = [NSScanner scannerWithString:textHexColor];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    self.textColor = [self colorWithRGBHex:hexNum];
}

- (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

- (NSString *)textHexColor{
    return @"0xffffff";
}

- (void)setFont:(UIFont *)font range:(NSRange )range
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.text];
    [string addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = string;
}

- (void)setTextColor:(UIColor *)color range:(NSRange )range
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.text];
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = string;
}

- (void)setTextColor:(UIColor *)color font:(UIFont *)font range:(NSRange )range
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.text];
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    [string addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = string;
}

@end
