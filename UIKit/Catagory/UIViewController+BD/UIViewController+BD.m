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
#import <StoreKit/StoreKit.h>

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

- (void)rateAppWithId:(NSString *)appId
{
    //评价
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"给个五星好评吧亲!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //跳转APPStore 中应用的撰写评价页面
    UIAlertAction *review = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *appReviewUrl = [NSURL URLWithString:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",@"APPID"]];//换成你应用的 APPID
        CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
        if (version >= 10.0) {
            /// 大于等于10.0系统使用此openURL方法
            [[UIApplication sharedApplication] openURL:appReviewUrl options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:appReviewUrl];
        }
    }];
    //不做任何操作
    UIAlertAction *noReview = [UIAlertAction actionWithTitle:@"用用再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertVC removeFromParentViewController];
    }];
    
    [alertVC addAction:review];
    [alertVC addAction:noReview];
    //判断系统,是否添加五星好评的入口
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
        UIAlertAction *fiveStar = [UIAlertAction actionWithTitle:@"五星好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [SKStoreReviewController requestReview];
        }];
        [alertVC addAction:fiveStar];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertVC animated:YES completion:nil];
    });
}
@end
