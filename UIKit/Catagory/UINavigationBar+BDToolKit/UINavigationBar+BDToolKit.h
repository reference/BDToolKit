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
#import <UIKit/UIKit.h>

@interface UINavigationBar (BDToolKit)

/**
 更改标题颜色和大小
 @param color 标题颜色
 @param font 标题大小
 */
- (void)navBarTitleColor:(UIColor *_Nullable)color font:(UIFont *_Nullable)font;

/**
 更改导航栏颜色和图片

 @param color 颜色
 @param barImage 图片
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)navBarBackGroundColor:(UIColor *_Nullable)color image:(UIImage *_Nullable)barImage isOpaque:(BOOL)opaque;

/**
 更改透明度

 @param alpha 导航栏透明度
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)navBarAlpha:(CGFloat)alpha isOpaque:(BOOL)opaque;

/**
 导航栏背景高度
 注意*这里并没有改导航栏高度，只是改了自定义背景高度

 @param height 高度
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)navBarMyLayerHeight:(CGFloat)height isOpaque:(BOOL)opaque;

/**
 隐藏底线
 */
- (void)navBarBottomLineHidden:(BOOL)hidden;

//还原回系统导航栏
- (void)navBarToBeSystem;
@end

#pragma mark -- 自定义导航栏层
@interface BDNavView :UIView
@property (nonatomic, assign) CGFloat   alpha;
@property (nonatomic, assign) BOOL      hiddenBottomLine;
@property (nonatomic, strong) UIColor   * _Nullable backColor;
@property (nonatomic, strong) UIImage   * _Nullable backImage;
@end
