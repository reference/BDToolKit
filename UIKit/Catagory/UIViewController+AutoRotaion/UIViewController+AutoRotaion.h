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
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(AutoRotaion)
// 当前方向
@property (nonatomic, assign) UIInterfaceOrientationMask ar_orientationMask;
// 是否子控制器
@property (nonatomic, assign) BOOL ar_isChildController;
/// 支持的方向
- (UIInterfaceOrientationMask)ar_supportedOrientations;
/// 转到指定方向
- (void)ar_turnToOrientation:(UIInterfaceOrientationMask)orientation;
/// 转为竖屏
- (void)ar_turnToPortrait;
/// 转为横屏
- (void)ar_turnToLandscape;
/// 添加特殊处理Controller，用于处理如 AlertContoller 等情况
+ (void)ar_addSpecialControllers:(NSArray<NSString *> *)controllers;
/// 移除特殊处理Controller
+ (void)ar_removeSpecialControllers:(NSArray<NSString *> *)controllers;
///
+ (BOOL)setOrientation:(UIInterfaceOrientationMask)orientation;
///
+ (UIInterfaceOrientationMask)windowTopViewControllerOrientationMask;
@end

NS_ASSUME_NONNULL_END
