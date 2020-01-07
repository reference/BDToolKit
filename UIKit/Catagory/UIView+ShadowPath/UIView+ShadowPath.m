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
#import "UIView+ShadowPath.h"

@implementation UIView (ShadowPath)

- (void)addShadowPathWithColor:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius pathType:(BDShadowPathType)pathType pathWidth:(CGFloat)pathWidth{
    
    self.layer.masksToBounds = NO;//必须要等于NO否则会把阴影切割隐藏掉
    self.layer.shadowColor = color.CGColor;// 阴影颜色
    self.layer.shadowOpacity = opacity;// 阴影透明度，默认0
    self.layer.shadowOffset = CGSizeZero;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowRadius = radius;//阴影半径，默认3
    CGRect shadowRect = CGRectZero;
    CGFloat originX,originY,sizeWith,sizeHeight;
    originX = 0;
    originY = 0;
    sizeWith = self.bounds.size.width;
    sizeHeight = self.bounds.size.height;
    
    if (pathType == BDShadowPathTop) {
        shadowRect = CGRectMake(originX, originY-pathWidth/2, sizeWith, pathWidth);
    }else if (pathType == BDShadowPathBottom){
        shadowRect = CGRectMake(originY, sizeHeight-pathWidth/2, sizeWith, pathWidth);
    }else if (pathType == BDShadowPathLeft){
        shadowRect = CGRectMake(originX-pathWidth/2, originY, pathWidth, sizeHeight);
    }else if (pathType == BDShadowPathRight){
        shadowRect = CGRectMake(sizeWith-pathWidth/2, originY, pathWidth, sizeHeight);
    }else if (pathType == BDShadowPathCommon){
        shadowRect = CGRectMake(originX-pathWidth/2, 2, sizeWith+pathWidth, sizeHeight+pathWidth/2);
    }else if (pathType == BDShadowPathAround){
        shadowRect = CGRectMake(originX-pathWidth/2, originY-pathWidth/2, sizeWith+pathWidth, sizeHeight+pathWidth);
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = bezierPath.CGPath;//阴影路径
}

@end
