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
#import "UIButton+Action.h"
#import <objc/runtime.h>

static const char *kQuickClick = "kQuickClick";

@implementation UIButton(Action)

- (void)setEnableQuickClick:(BOOL)enableQuickClick
{
    NSNumber *number = [NSNumber numberWithBool:enableQuickClick];
    objc_setAssociatedObject(self,kQuickClick, number,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enableQuickClick
{
    NSNumber *number = objc_getAssociatedObject(self, kQuickClick);
    return [number boolValue];
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([target isKindOfClass:UIViewController.class] || [target isKindOfClass:UITableViewController.class] || [target isKindOfClass:UICollectionViewController.class]) {
        UIViewController *vc = target;
        [vc.view endEditing:YES];
    }
    // fix quick clicked bug
    if (self.enableQuickClick) {
        [super sendAction:action to:target forEvent:event];
    }
    else{
        static BOOL enable = YES;
        if (enable) {
            [super sendAction:action to:target forEvent:event];
            enable = NO;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            enable = YES;
        });
    }
}

@end
