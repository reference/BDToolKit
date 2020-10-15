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
#import "BDMovingIcon.h"

#define Width 50
#define Height 50

@interface BDMovingIcon()
@property(nonatomic,assign) BOOL MoveEnable;
@property(nonatomic,assign) BOOL MoveEnabled;
@property(nonatomic,assign) CGPoint beginpoint;
@end

@implementation BDMovingIcon

+ (id)showInController:(UIViewController *)vc
{
    if (vc) {
        
        BDMovingIcon *b = [BDMovingIcon buttonWithType:UIButtonTypeCustom];
        b.MoveEnable = YES;
        [b addTarget:b action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        b.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 250, Width, Height);
        [vc.view addSubview:b];
        [vc.view bringSubviewToFront:b];
        return b;;
    }return nil;
}

- (void)setIcon:(UIImage *)icon
{
    [self setBackgroundImage:icon forState:UIControlStateNormal];
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (IBAction)onButtonClicked:(UIButton *)b
{
    if (self.onButtonClickedCallback) {
        self.onButtonClickedCallback();
    }
}

//开始触摸的方法
//触摸-清扫
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.MoveEnabled = NO;
    [super touchesBegan:touches withEvent:event];
    if (!self.MoveEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    self.beginpoint = [touch locationInView:self];
}

//触摸移动的方法

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    self.MoveEnabled = YES;//单击事件可用
    if (!self.MoveEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    //偏移量
    float offsetX = currentPosition.x - self.beginpoint.x;
    float offsetY = currentPosition.y - self.beginpoint.y;
    //移动后的中心坐标
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
    
    //x轴左右极限坐标
    if (self.center.x > (self.superview.frame.size.width-self.frame.size.width/2))
    {
        CGFloat x = self.superview.frame.size.width-self.frame.size.width/2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    }else if (self.center.x < self.frame.size.width/2)
    {
        CGFloat x = self.frame.size.width/2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    }
    
    //y轴上下极限坐标
    if (self.center.y > (self.superview.frame.size.height-self.frame.size.height/2)) {
        CGFloat x = self.center.x;
        CGFloat y = self.superview.frame.size.height-self.frame.size.height/2;
        self.center = CGPointMake(x, y);
    }else if (self.center.y <= self.frame.size.height/2){
        CGFloat x = self.center.x;
        CGFloat y = self.frame.size.height/2;
        self.center = CGPointMake(x, y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.MoveEnable) {
        return;
    }
    
    if (self.center.x >= self.superview.frame.size.width/2) {//向右侧移动
        //偏移动画
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        self.frame=CGRectMake(self.superview.frame.size.width - Width,self.center.y-20, Width,Height);
        //提交UIView动画
        [UIView commitAnimations];
    }else{//向左侧移动
        
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        self.frame=CGRectMake(0.f,self.center.y-20, Width,Height);
        //提交UIView动画
        [UIView commitAnimations];
        
    }
    
    //不加此句话，UIButton将一直处于按下状态
    [super touchesEnded: touches withEvent: event];
    
}

//外界因素取消touch事件，如进入电话
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
@end
