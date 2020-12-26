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
#import "BDPOPNumberAnimation.h"

@interface BDPOPNumberAnimation ()

@property (nonatomic, strong) POPBasicAnimation  *conutAnimation;

@end

@implementation BDPOPNumberAnimation

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.conutAnimation = [POPBasicAnimation animation];
    }
    
    return self;
}

- (void)saveValues {
    
    self.conutAnimation.fromValue = @(self.fromValue);
    self.conutAnimation.toValue   = @(self.toValue);
    self.conutAnimation.duration  = (self.duration <= 0 ? 0.4f : self.duration);
    
    if (self.timingFunction) {
        
        self.conutAnimation.timingFunction = self.timingFunction;
    }
}

- (void)startAnimation {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BDPOPNumberAnimation:currentValue:)]) {
        
        __weak BDPOPNumberAnimation *weakSelf = self;
        
        // 将计算出来的值通过writeBlock动态给控件设定
        self.conutAnimation.property = \
            [POPMutableAnimatableProperty propertyWithName:@"conutAnimation" initializer:^(POPMutableAnimatableProperty *prop) {
                
            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                
                weakSelf.currentValue = values[0];
                [weakSelf.delegate BDPOPNumberAnimation:weakSelf currentValue:values[0]];
            };
        }];
        
        // 添加动画
        [self pop_addAnimation:self.conutAnimation forKey:nil];
    }
    
    if (self.animationCallback) {
        __weak BDPOPNumberAnimation *weakSelf = self;
        
        // 将计算出来的值通过writeBlock动态给控件设定
        self.conutAnimation.property = \
            [POPMutableAnimatableProperty propertyWithName:@"conutAnimation" initializer:^(POPMutableAnimatableProperty *prop) {
                
            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                
                weakSelf.currentValue = values[0];
                weakSelf.animationCallback(weakSelf, values[0]);
            };
        }];
        
        // 添加动画
        [self pop_addAnimation:self.conutAnimation forKey:nil];
    }
}

- (void)stopAnimation {
    
    [self pop_removeAllAnimations];
}

@end
