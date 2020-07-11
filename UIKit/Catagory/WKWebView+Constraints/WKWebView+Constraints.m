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
#import "WKWebView+Constraints.h"
#import <objc/runtime.h>

static const char *kTop = "__kTop__v";
static const char *kBottom = "__kBottom__v";
static const char *kLeft = "__kLeft__v";
static const char *kRight = "__kRight__v";
static const char *kWidth = "__kWidth__v";
static const char *kHeight = "__kHeight__v";
static const char *kOther = "__kOther__v";
static const char *kCenterX = "__kCenterX__v";
static const char *kCenterY = "__kCenterY__v";

@implementation WKWebView(Constraints)
//top
- (NSLayoutConstraint *)topLayoutConstraint
{
    return objc_getAssociatedObject(self, kTop);
}

- (void)setTopLayoutConstraint:(NSLayoutConstraint *)topLayoutConstraint
{
    objc_setAssociatedObject(self,kTop, topLayoutConstraint,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//bottom
- (NSLayoutConstraint *)bottomLayoutConstraint
{
    return objc_getAssociatedObject(self, kBottom);
}

- (void)setBottomLayoutConstraint:(NSLayoutConstraint *)bottomLayoutConstraint
{
    objc_setAssociatedObject(self,kBottom, bottomLayoutConstraint,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//left
- (NSLayoutConstraint *)leftLayoutConstraint
{
    return objc_getAssociatedObject(self, kLeft);
}

- (void)setLeftLayoutConstraint:(NSLayoutConstraint *)leftLayoutConstraint
{
    objc_setAssociatedObject(self,kLeft, leftLayoutConstraint,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//right
- (NSLayoutConstraint *)rightLayoutConstraint
{
    return objc_getAssociatedObject(self, kRight);
}

- (void)setRightLayoutConstraint:(NSLayoutConstraint *)rightLayoutConstraint
{
    objc_setAssociatedObject(self,kRight, rightLayoutConstraint,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//width
- (NSLayoutConstraint *)widthLayoutConstraint
{
    return objc_getAssociatedObject(self, kWidth);
}

- (void)setWidthLayoutConstraint:(NSLayoutConstraint *)widthLayoutConstraint
{
    objc_setAssociatedObject(self,kWidth, widthLayoutConstraint,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//height
- (NSLayoutConstraint *)heightLayoutConstraint
{
    return objc_getAssociatedObject(self, kHeight);
}

- (void)setHeightLayoutConstraint:(NSLayoutConstraint *)heightLayoutConstraint
{
    objc_setAssociatedObject(self,kHeight, heightLayoutConstraint,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//center x
- (NSLayoutConstraint *)centerXLayoutConstraint
{
    return objc_getAssociatedObject(self, kCenterX);
}

- (void)setCenterXLayoutConstraint:(NSLayoutConstraint *)centerXLayoutConstraint
{
    objc_setAssociatedObject(self,kCenterX, centerXLayoutConstraint,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//center y
- (NSLayoutConstraint *)centerYLayoutConstraint
{
    return objc_getAssociatedObject(self, kCenterY);
}

- (void)setCenterYLayoutConstraint:(NSLayoutConstraint *)centerYLayoutConstraint
{
    objc_setAssociatedObject(self,kCenterY, centerYLayoutConstraint,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//other
- (NSLayoutConstraint *)otherLayoutConstraint
{
    return objc_getAssociatedObject(self, kOther);
}

- (void)setOtherLayoutConstraint:(NSLayoutConstraint *)otherLayoutConstraint
{
    objc_setAssociatedObject(self,kOther, otherLayoutConstraint,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
