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
#import "BDVerifyCodeField.h"

typedef NS_OPTIONS(NSUInteger, FieldBorderType) {
    FieldBorderTypeDefault = 0,
    FieldBorderTypeHighlight = 1,
    FieldBorderTypeNone = 2,
};

@class BDVerifyCodeView;
@protocol BDVerifyCodeViewDelegate <NSObject>

/**
 验证码输入完成后的回调

 @param verifyCodeView verifyCodeView
 @param codeString codeString
 */
- (void)verifyCodeViewDidFinshed:(BDVerifyCodeView *)verifyCodeView CodeString:(NSString *)codeString;
@end

@interface BDVerifyCodeView : UIView<BDVerifyCodeFieldDeleteDelegate>

/**
 验证码长度 默认6位
 */
@property (nonatomic, assign) IBInspectable int CodeCount;

/**
 验证码边框颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *normalColor;

/**
 验证码边框高亮颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *highlightColor;

/**
 验证码光标颜色 默认与normalColor一致
 FieldBorderTypeNone时 默认无光标，可单独设置
 */
@property (nonatomic, strong) IBInspectable UIColor *cursorColor;

/**
 验证码字符颜色 默认黑色
 */
@property (nonatomic, strong) IBInspectable UIColor *codeColor;

/**
 验证码字体大小 默认26
 */
@property (nonatomic, assign) IBInspectable CGFloat fontSize;

/**
 验证码控件风格
 */
@property (nonatomic, assign) IBInspectable FieldBorderType fieldBorderType;

/**
 FieldBorderTypeNone时的验证码间距 默认为10
 */
@property (nonatomic, assign) IBInspectable CGFloat margin;

/**
 代理对象
 */
@property (nonatomic, weak) IBOutlet id<BDVerifyCodeViewDelegate> delegate;

/**
 当前输入的验证码
 */
@property (nonatomic, strong) NSString *codeString;


/**
 是否安全输入 默认NO
 */
@property (nonatomic, assign) IBInspectable BOOL isSecurity;

/**
 实例方法 创建一个BDVerifyCodeView

 @param type BorderType
 @param normalColor normalColor
 @param highlightColor highlightColor
 @return BDVerifyCodeView
 */
- (instancetype)initWithFieldBorderType:(FieldBorderType)type NormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor;

/**
 类方法 创建一个BDVerifyCodeView

 @param type BorderType
 @param normalColor normalColor
 @param highlightColor highlightColor
 @return BDVerifyCodeView
 */
+ (instancetype)verifyCodeViewBorderType:(FieldBorderType)type NormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor;

/**
 创建一个Default风格的BDVerifyCodeView
 */
+ (instancetype)verifyCodeViewBorderTypeDefaultNormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor CursorColor:(UIColor *)cursorColor CodeColor:(UIColor *)codeColor;

/**
 创建一个Highlight风格的BDVerifyCodeView
 */
+ (instancetype)verifyCodeViewBorderTypeHighlightNormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor CursorColor:(UIColor *)cursorColor CodeColor:(UIColor *)codeColor;

/**
 创建一个None风格的BDVerifyCodeView
 */
+ (instancetype)verifyCodeViewBorderTypeNoneNormalColor:(UIColor *)normalColor CursorColor:(UIColor *)cursorColor CodeColor:(UIColor *)codeColor Margin:(CGFloat)margin;
@end
