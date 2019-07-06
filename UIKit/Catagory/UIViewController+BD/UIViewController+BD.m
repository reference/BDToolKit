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

#import "UIViewController+BD.h"

@implementation UIViewController(BD)

- (void)performSegueWithClass:(Class)cls sender:(id)sender
{
    [self performSegueWithIdentifier:NSStringFromClass(cls) sender:sender];
}

- (void)presentNavigationViewController:(NSString *)navControllerName inStoryboard:(NSString *)storyboardName
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UINavigationController *nv = [sb instantiateViewControllerWithIdentifier:navControllerName];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nv animated:YES completion:nil];
}

- (void)pushViewControllerClass:(Class)cls inStoryboard:(NSString *)storyboardName
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(cls)];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushViewControllerClass:(Class)cls inStoryboard:(NSString *)storyboardName block:(void(^)(UIViewController *vc))block
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(cls)];
    if (block) {
        block(vc);
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
