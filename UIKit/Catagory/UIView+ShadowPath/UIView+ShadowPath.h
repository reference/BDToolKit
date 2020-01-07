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
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , BDShadowPathType) {
    BDShadowPathTop    = 1,
    BDShadowPathBottom = 2,
    BDShadowPathLeft   = 3,
    BDShadowPathRight  = 4,
    BDShadowPathCommon = 5,
    BDShadowPathAround = 6
};

@interface UIView (ShadowPath)

/**
 Add shadow to UIView
 @param color shadow color
 @param opacity 阴影透明度 默认0
 @param radius 阴影半径 也就是阴影放射程度 默认3
 @param pathType 阴影方向
 @param pathWidth 阴影放射g宽度
 */
- (void)addShadowPathWithColor:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius pathType:(BDShadowPathType)pathType pathWidth:(CGFloat)pathWidth;
@end

NS_ASSUME_NONNULL_END
