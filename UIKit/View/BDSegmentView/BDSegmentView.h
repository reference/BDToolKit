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
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BDSegmentView : UIView
/**
 Item titles
 Important: Seperate by ','
 */
@property (nonatomic, assign) IBInspectable NSString *items;
@property (nonatomic, strong) IBInspectable UIFont *itemFont;
@property (nonatomic, strong) IBInspectable UIColor *normalItemColor;
@property (nonatomic, strong) IBInspectable UIColor *selectedItemColor;
@property (nonatomic, assign) IBInspectable NSInteger selectedIndex;

//underline
@property (nonatomic, strong) IBInspectable UIColor *underLineColor;
@property (nonatomic, assign) IBInspectable CGFloat underLineWidth;
@property (nonatomic, assign) IBInspectable CGFloat underLineHeight;

@property (nonatomic, copy) void (^selectedAtIndex)(NSInteger index);
@end
