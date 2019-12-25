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
#import "UIResponder+AutoRotation.h"
#import <objc/runtime.h>

static inline void rp_exchangeMethod(Class originCls, SEL originSelector, Class targetCls, SEL targetSelector) {
    Method originalMethod = class_getInstanceMethod(targetCls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(targetCls, targetSelector);
    BOOL success = class_addMethod(originCls,
                                   originSelector,
                                   method_getImplementation(swizzledMethod),
                                   method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(originCls,
                            targetSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UIResponder(AutoRotation)

+ (void)load {
    rp_exchangeMethod(self, @selector(application:supportedInterfaceOrientationsForWindow:), self, @selector(ar_application:supportedInterfaceOrientationsForWindow:));
}

- (UIInterfaceOrientationMask)ar_application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    UIInterfaceOrientationMask mask = [UIViewController windowTopViewControllerOrientationMask];
    [UIViewController setOrientation:mask];
    return mask;
}

@end
