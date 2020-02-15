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
#import "BDComponentFactory.h"

@implementation BDComponentFactory

+ (UIView *)viewWithFrame:(CGRect)frame supperView:(UIView *)view
{
    UIView *v = [[UIView alloc] initWithFrame:frame];
    v.backgroundColor = [UIColor clearColor];
    if (view) {
        [view addSubview:v];
    }
    return v;
}

//label
+ (UILabel *)labelWithFrame:(CGRect)frame
                  textColor:(UIColor *)color
              textAlignment:(NSTextAlignment)alignment
                       font:(UIFont *)font
                       text:(NSString *)text
                 supperView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (color) {
        label.textColor = color;
    }
    label.textAlignment = alignment;
    label.text = text;
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    if (view) {
        [view addSubview:label];
    }
    return label;
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage *)image
                         supperView:(UIView *)view
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = image;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    if (view) {
        [view addSubview:imgView];
    }
    return imgView;
}

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
                         supperView:(UIView *)view
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.clearButtonMode = clearButtonMode;
    textField.backgroundColor = backgroundColor;
    textField.placeholder = placeHolder;
    textField.text = text;
    if (color) {
        textField.textColor = color;
    }
    textField.textAlignment = alignment;
    if (font) {
        textField.font = font;
    }
    textField.contentVerticalAlignment = verticalAlignment;
    textField.background = image;
    textField.secureTextEntry = securty;
    textField.delegate = delegate;
    if (view) {
        [view addSubview:textField];
    }
    return textField;
}

+ (UIButton *)buttonWithType:(UIButtonType)type
                       frame:(CGRect)frame
                       taget:(id)target
                      action:(SEL)selector
                  supperView:(UIView *)view
{
    UIButton *b = [UIButton buttonWithType:type];
    b.frame = frame;
    [b addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if (view) {
        [view addSubview:b];
    }
    return b;
}

+ (UITableView *)tableViewWithFrame:(CGRect)frame
                              style:(UITableViewStyle)style
                           delegate:(id<UITableViewDelegate>)delegate
                         dataSource:(id<UITableViewDataSource>)dataSource
                         supperView:(UIView *)view
{
    UITableView *table = [[UITableView alloc] initWithFrame:frame style:style];
    table.delegate = delegate;
    table.dataSource = dataSource;
    table.backgroundColor = [UIColor whiteColor];
    table.backgroundView = nil;
    table.showsVerticalScrollIndicator = NO;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (view) {
        [view addSubview:table];
    }
    return table;
}

+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame
                          contentSize:(CGSize)contentSize
                             delegate:(id <UIScrollViewDelegate>)delegate
                           supperView:(UIView *)view
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:frame];
    sc.delegate = delegate;
    sc.showsVerticalScrollIndicator = NO;
    sc.contentSize = contentSize;
    
    if (view) {
        [view addSubview:sc];
    }
    
    return sc;
}

+ (UIButton *)blueStyleButtonWithWidth:(CGFloat)width
                                 origin:(CGPoint)point
                                  title:(NSString *)title
                                  taget:(id)target
                                 action:(SEL)action
                                 inView:(UIView*)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(point.x, point.y, width, 40);
	[button setTitle:title  forState:UIControlStateNormal];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
	button.backgroundColor = [UIColor colorWithRed:0/255.f green:122/255.f blue:255/255.f alpha:1];
	button.layer.cornerRadius = 5;
//	button.layer.borderWidth = 1;
//	button.layer.borderColor = COLOR_RGBA(213.0, 213.0, 213.0, 1.0).CGColor;
    
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (view) {
        [view addSubview:button];
    }
    return button;
}

+ (UIButton *)textStyleButtonWithWidth:(CGFloat)width
                                origin:(CGPoint)point
                                 title:(NSString *)title
                                 taget:(id)target
                                action:(SEL)action
                                inView:(UIView*)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(point.x, point.y, width, 30);
	[button setTitle:title  forState:UIControlStateNormal];
	[button setTitleColor:[UIColor colorWithRed:97/255.f green:97/255.f blue:97/255.f alpha:1]
                 forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
	button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
	button.backgroundColor = [UIColor clearColor];
    
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (view) {
        [view addSubview:button];
    }
    return button;
}

@end
