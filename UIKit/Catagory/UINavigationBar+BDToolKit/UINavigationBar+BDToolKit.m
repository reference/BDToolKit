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
#import "UINavigationBar+BDToolKit.h"
#import <objc/runtime.h>
@class BDNavView;

@interface UINavigationBar()
@property (nonatomic, strong) UIImage       *backClearImage;
@property (nonatomic, strong) UIImage       *lineClearImage;
@property (nonatomic, strong) BDNavView     *myNavView; //自定义插入层，自定义操作都要在这一层上进行
@property (nonatomic, assign) BOOL          hiddenBottom;
@end

static char backClear_key, lineClear_key, myNavView_key, hiddenBottom_key;

@implementation UINavigationBar (handle)

#pragma mark -- runtime:get/set
- (void)setBackClearImage:(UIImage *)backClearImage {
    objc_setAssociatedObject(self, &backClear_key, backClearImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)backClearImage {
    return objc_getAssociatedObject(self, &backClear_key);
}

- (void)setLineClearImage:(UIImage *)lineClearImage {
    objc_setAssociatedObject(self, &lineClear_key, lineClearImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)lineClearImage {
    return objc_getAssociatedObject(self, &lineClear_key);
}

- (void)setMyNavView:(BDNavView *)myNavView {
    objc_setAssociatedObject(self, &myNavView_key, myNavView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BDNavView *)myNavView {
    return objc_getAssociatedObject(self, &myNavView_key);
}

- (void)setHiddenBottom:(BOOL)hiddenBottom {
    objc_setAssociatedObject(self, &hiddenBottom_key, @(hiddenBottom), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hiddenBottom {
    return [objc_getAssociatedObject(self, &hiddenBottom_key) boolValue];
}

#pragma mark -- function
- (void)navBarTitleColor:(UIColor *)color font:(UIFont *)font {
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName : color,
    NSFontAttributeName : font}];
}

- (void)navBarAlpha:(CGFloat)alpha isOpaque:(BOOL)opaque {
    [self clearSystemLayerIsOpaque:opaque];
    if (!self.myNavView) {
        //状态栏高度
        CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        //导航栏高度
        CGFloat barHeight = self.bounds.size.height;
        CGRect barBounds = self.bounds;
        barBounds.size.height = statusHeight + barHeight;
        [[self customNavBar]setFrame:barBounds];
    }
    
    self.myNavView.alpha = alpha;
    
    //通过kvc找到系统导航栏背景层，把自定义层添加到背景层
    /* 系统背景层无法改变其属性 所以通过添加自定义层，改变自定义层去实现效果*/
    [[self valueForKey:@"backgroundView"] addSubview:self.myNavView];
}

- (void)navBarBackGroundColor:(UIColor *)color image:(UIImage *)barImage isOpaque:(BOOL)opaque {
    [self clearSystemLayerIsOpaque:opaque];
    if (!self.myNavView) {
        //状态栏高度
        CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        //导航栏高度
        CGFloat barHeight = self.bounds.size.height;
        
        CGRect barBounds = self.bounds;
        barBounds.size.height = statusHeight + barHeight;
        [[self customNavBar]setFrame:barBounds];
    }
    
    if (color) {
        self.myNavView.backColor = color;
    }
    
    if (barImage) {
        self.myNavView.backImage = barImage;
    }
    
    //通过kvc找到系统导航栏背景层，把自定义层添加到背景层
    /*系统背景层无法改变其属性 所以通过添加自定义层，改变自定义层上的属性去实现效果*/
    [[self valueForKey:@"backgroundView"] addSubview:self.myNavView];
}

- (void)navBarMyLayerHeight:(CGFloat)height isOpaque:(BOOL)opaque {
    height = height < 0 ? 0 : height;
    
    [self clearSystemLayerIsOpaque:opaque];
    [[self customNavBar]setFrame:CGRectMake(0, 0, self.bounds.size.width, height)];

    //通过kvc找到系统导航栏背景层，把自定义层添加到背景层
    /* 亲测，系统背景层无法改变其属性 所以通过添加自定义层，改变自定义层上的属性去实现效果*/
    [[self valueForKey:@"backgroundView"] addSubview:self.myNavView];
}

- (void)navBarBottomLineHidden:(BOOL)hidden {
    if (self.hiddenBottom == hidden) return;
    self.hiddenBottom = hidden;
    //如果是自定义图层
    [self customNavBar];
    if (self.myNavView.hiddenBottomLine != hidden) {
        self.myNavView.hiddenBottomLine = hidden;
        
    }
    //如果是系统层
    if (hidden) {
        if (!self.lineClearImage) {
            self.lineClearImage = [[UIImage alloc]init];
            [self setShadowImage:self.lineClearImage];
        }
    } else {
        if (self.lineClearImage) {
            self.lineClearImage = nil;
            [self setShadowImage:self.lineClearImage];
        }
    }
}

//还原到系统初始状态
- (void)navBarToBeSystem {
    if (self.myNavView) {
        [self.myNavView removeFromSuperview];
        self.myNavView = nil;
    }
    if (self.lineClearImage) {
        self.lineClearImage = nil;
    }
    if (self.backClearImage) {
        self.backClearImage = nil;
    }
    [self setBackgroundImage:nil
               forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    self.barStyle = UIBarStyleDefault;
}

//去掉系统导航栏特征
- (void)clearSystemLayerIsOpaque:(BOOL)opaque{
    //通过插入空image把背景变透明
    if (!self.backClearImage) {
        self.backClearImage = [[UIImage alloc]init];
        [self setBackgroundImage:self.backClearImage
                   forBarMetrics:UIBarMetricsDefault];
    }
    self.barStyle = opaque ? UIBarStyleBlackOpaque : UIBarStyleDefault;
    //去掉系统底线，使用自定义底线
    if (!self.lineClearImage) {
        self.lineClearImage = [[UIImage alloc]init];
        [self setShadowImage:self.lineClearImage];
    }
}

- (BDNavView *)customNavBar {
    if (!self.myNavView) {
        self.myNavView = [[BDNavView alloc]init];
    }
    return self.myNavView;
}
@end

#pragma mark -- 自定义导航栏层
@interface BDNavView()
@property (nonatomic, strong) UIImageView * _Nullable backImageView;
@property (nonatomic, strong) UIView * _Nullable bottomLine;
@end

@implementation BDNavView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self creatMainUIByFrame:frame];
}

- (void)creatMainUIByFrame:(CGRect)frame {
    CGFloat height = frame.size.height;
    CGFloat width = frame.size.width;
    [self.backImageView setFrame:CGRectMake(0, 0, width, height)];
    [self addSubview:self.backImageView];
    
    [self.bottomLine setFrame:CGRectMake(0, height-0.5, width, 0.5)];
    [self addSubview:self.bottomLine];
}

//底层背景层永远透明
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
}

//设置图片背景颜色
- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.backImageView.backgroundColor = backColor;
}

//设置图片背景透明度
- (void)setAlpha:(CGFloat)alpha {
    _alpha = alpha;
    self.backImageView.alpha = alpha;
}

//设置图片
- (void)setBackImage:(UIImage *)backImage {
    _backImage = backImage;
    self.backImageView.image = backImage;
}

- (void)setHiddenBottomLine:(BOOL)hiddenBottomLine {
    _hiddenBottomLine = hiddenBottomLine;
    self.bottomLine.hidden = hiddenBottomLine;
}

#pragma mark -- 懒加载视图
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.clipsToBounds = YES;
        _backImageView.contentMode = UIViewContentModeTop;
    }
    return _backImageView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        [_bottomLine setBackgroundColor:[UIColor grayColor]];
    }
    return _bottomLine;
}
@end
