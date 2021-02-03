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
#import "BDVerifyCodeField.h"


@interface BDVerifyCodeField()<UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *arrBorderLayer;
@end


@implementation BDVerifyCodeField

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textColor = [UIColor clearColor];
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.arrBorderLayer = [NSMutableArray array];
        self.font = [UIFont systemFontOfSize:26];
        self.lblCode = [[UILabel alloc] init];
        self.lblCode.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lblCode];
    }
    return self;
}

-(void)layoutSubviews
{
    self.lblCode.frame = self.bounds;
}

- (void)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType
{
    
    if (borderType == UIBorderSideTypeAll) {
        borderType = UIBorderSideTypeLeft|UIBorderSideTypeRight|UIBorderSideTypeTop|UIBorderSideTypeBottom;
    }

    // 左侧
    if (borderType & UIBorderSideTypeLeft) {
        // 左侧线路径
        CAShapeLayer *borderlayer = [self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth];
        [self.layer addSublayer:borderlayer];
        [self.arrBorderLayer addObject:borderlayer];
    }
    
    // 右侧
    if (borderType & UIBorderSideTypeRight) {
        // 右侧线路径
        CAShapeLayer *borderlayer = [self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake(self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth];
        [self.layer addSublayer:borderlayer];
        [self.arrBorderLayer addObject:borderlayer];
    }
    
    /// top
    if (borderType & UIBorderSideTypeTop) {
        /// top线路径
        CAShapeLayer *borderlayer = [self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth];
        [self.layer addSublayer:borderlayer];
        [self.arrBorderLayer addObject:borderlayer];
    }
    
    /// bottom
    if (borderType & UIBorderSideTypeBottom) {
        /// bottom线路径
        CAShapeLayer *borderlayer = [self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth];
        [self.layer addSublayer:borderlayer];
        [self.arrBorderLayer addObject:borderlayer];
    }
}

- (void)removeBorderLayer
{
    for (CAShapeLayer *layer in self.arrBorderLayer)
    {
        [layer removeFromSuperlayer];
    }
    [self.arrBorderLayer removeAllObjects];
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}

- (void)deleteBackward
{
    // 后退按钮分2种情况  1 未输入完，则当前字符是空「此情况不会进入ControlEvents事件」 2 已输入完 处于最后一个字符 且当前字符存在
    if ([self.text isEqualToString:@""])
    {
        if (self.deleteDelegate && [self.deleteDelegate respondsToSelector:@selector(verifyCodeFieldDeleteBackwardClicked:)]) {
            [self.deleteDelegate verifyCodeFieldDeleteBackwardClicked:self];
        }
    }
    [super deleteBackward];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 控制字符个数 用于最后一个字符的连续输入判断
    if (![string isEqualToString:@""])
    {
        if (textField.text.length >= 1)
        {
            [self resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

@end
