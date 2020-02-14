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
@interface BDComponentFactory : NSObject

//UIView
+ (UIView *)viewWithFrame:(CGRect)frame supperView:(UIView *)view;

//label
+ (UILabel *)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)color
              textAlignment:(NSTextAlignment)alignment
                       font:(UIFont *)font
                       text:(NSString *)text
                 supperView:(UIView *)view;

//UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage *)image
                         supperView:(UIView *)view;

//UITextField
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                        placeHolder:(NSString *)placeHolder
                    clearButtonMode:(UITextFieldViewMode)clearButtonMode
                               text:(NSString *)text
                          textColor:(UIColor *)color
                      textAlignment:(NSTextAlignment)alignment
         contentVerticalAlignment:(UIControlContentVerticalAlignment)verticalAlignment
                               font:(UIFont *)font
                         backGround:(UIImage*)image
                    backgroundColor:(UIColor *)backgroundColor
                           delegate:(id<UITextFieldDelegate>)delegate
                          isSecurty:(BOOL)securty
                         supperView:(UIView *)view;

//UIButton
+ (UIButton *)buttonWithType:(UIButtonType)type
                       frame:(CGRect)frame
                       taget:(id)target
                      action:(SEL)selector
                  supperView:(UIView *)view;

//UITableView
+ (UITableView *)tableViewWithFrame:(CGRect)frame
                              style:(UITableViewStyle)style
                           delegate:(id<UITableViewDelegate>)delegate
                         dataSource:(id<UITableViewDataSource>)dataSource
                         supperView:(UIView *)view;

//UIScrollView
+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame
                          contentSize:(CGSize)contentSize
                             delegate:(id <UIScrollViewDelegate>)delegate
                           supperView:(UIView *)view;
//UIWebView
+ (UIWebView *)webViewWithFrame:(CGRect)frame delegate:(id<UIWebViewDelegate>)delegate supperView:(UIView *)supperView;


//登录样式按钮 蓝底白字
+ (UIButton *)blueStyleButtonWithWidth:(CGFloat)width
                                 origin:(CGPoint)point
                                  title:(NSString *)title
                                  taget:(id)target
                                 action:(SEL)action
                                 inView:(UIView*)view;

//文本样式按钮 灰色字体
+ (UIButton *)textStyleButtonWithWidth:(CGFloat)width
                                origin:(CGPoint)point
                                 title:(NSString *)title
                                 taget:(id)target
                                action:(SEL)action
                                inView:(UIView*)view;
@end
