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
#import "UITextField+BDQuickSecurityCode.h"
#import <objc/runtime.h>

@implementation UITextField (BDQuickSecurityCode)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(yx_deleteBackward));
    method_exchangeImplementations(method1, method2);
    
    method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"becomeFirstResponder"));
    method2 = class_getInstanceMethod([self class], @selector(yx_becomeFirstResponder));
    method_exchangeImplementations(method1, method2);
}

- (void)yx_deleteBackward {
    [self yx_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <BDQuickSecurityCodeTextFieldDelegate> delegate  = (id<BDQuickSecurityCodeTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
}

-(BOOL)yx_becomeFirstResponder
{
    if ([self.delegate respondsToSelector:@selector(textFieldBecomeFirstResponder:)])
    {
        id <BDQuickSecurityCodeTextFieldDelegate> delegate  = (id<BDQuickSecurityCodeTextFieldDelegate>)self.delegate;
        [delegate textFieldBecomeFirstResponder:self];
    }
    return  [self yx_becomeFirstResponder];
}

@end
