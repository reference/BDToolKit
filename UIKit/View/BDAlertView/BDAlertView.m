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

#import "BDAlertView.h"

typedef void (^BDAlertActionHandler)(BDAlertAction *action);

@interface BDAlertAction ()
@property (nonatomic, copy) BDAlertActionHandler handler;

@end

@implementation BDAlertAction

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(BDAlertAction *action))handler {
    return [[[self class] alloc] initWithTitle:title handler:handler];
};

- (instancetype)initWithTitle:(NSString *)title handler:(void (^)(BDAlertAction *action))handler {
    self = [super init];
    if (self) {
        self.title = title;
        self.handler = handler;
        self.style = BDAlertActionStyleDefault;
    }
    return self;
}

@end

@interface BDAlertView () <UIAlertViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) NSMutableArray *alertActions;
@property (nonatomic, strong) UIAlertController *alertController NS_AVAILABLE_IOS(8_0);
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) NSArray<UITextField *> *textFields;

@end

@implementation BDAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(BDAlertViewStyle)style cancelAction:(BDAlertAction *)cancelAction otherAction:(BDAlertAction *)otherAction, ... {
    self = [super init];
    if (self) {
        _title = [title copy];
        _message = [message copy];
        _style = style;
        //
        if (@available(iOS 8.0, *)) {
            self.alertController = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:(NSInteger)style];
        } else {
            //
            if (_style == BDAlertViewStyleAlert) {
                self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelAction.title otherButtonTitles:nil];
                [self.alertView insertSubview:self atIndex:0];
            } else if (_style == BDAlertViewStyleActionSheet) {
                self.actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelAction.title destructiveButtonTitle:nil otherButtonTitles:nil];
                [self.actionSheet insertSubview:self atIndex:0];
            }
        }
        //
        if (cancelAction) {
            cancelAction.style = BDAlertActionStyleCancel;
            [self addAction:cancelAction];
        }
        //
        if (otherAction) {
            [self addAction:otherAction];
            //
            va_list vaList;
            va_start(vaList, otherAction);
            id obj;
            while ((obj = va_arg(vaList, id))) {
                if ([obj isKindOfClass:[BDAlertAction class]]) {
                    BDAlertAction *action = obj;
                    [self addAction:action];
                }
            }
            va_end(vaList);
        }
    }
    //
    return self;
}

#pragma mark Actions

- (void)addAction:(BDAlertAction *)action {
    if (action) {
        if (self.alertActions == nil) {
            self.alertActions = [[NSMutableArray alloc] init];
        }
        [self.alertActions addObject:action];
        //
        if (@available(iOS 8.0, *)) {
            UIAlertAction *obj = [UIAlertAction actionWithTitle:action.title style:(NSInteger)action.style handler:^(UIAlertAction * _Nonnull a) {
                if (action.handler) {
                    action.handler(action);
                }
            }];
            [self.alertController addAction:obj];
        } else if (self.actionSheet) {
            [self.actionSheet addButtonWithTitle:action.title ? action.title : @""];
            if (action.style == BDAlertActionStyleDestructive) {
                NSInteger index = [self.alertActions indexOfObject:action];
                self.actionSheet.destructiveButtonIndex = index;
            }
        } else if (self.alertView) {
            [self.alertView addButtonWithTitle:action.title ? action.title : @""];
        }
    }
}

- (NSArray<BDAlertAction *> *)actions {
    return [self.alertActions copy];
}

#pragma mark textFields

- (void)addTextField:(void (^)(UITextField *textField))configurationHandler {
    if (@available(iOS 8.0, *)) {
        __weak typeof(self) weakSelf = self;
        [self.alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            if (textField) {
                weakSelf.textFields = [weakSelf.textFields arrayByAddingObject:textField];
            }
            if (configurationHandler) {
                configurationHandler(textField);
            }
        }];
        
    } else {
        UITextField *textField = [self.alertView textFieldAtIndex:_textFields.count];
        if (textField) {
            _textFields = [self.textFields arrayByAddingObject:textField];
        }
        if (configurationHandler) {
            configurationHandler(textField);
        }
    }
}

#pragma mark Show

- (void)showInViewController:(UIViewController *)viewController {
    [self showInViewController:viewController sourceView:nil];
}

- (void)showInViewController:(UIViewController *)viewController sourceView:(UIView *)sourceView {
    [self showInViewController:viewController sourceView:sourceView sourceRect:sourceView.bounds];
}

- (void)showInViewController:(UIViewController *)viewController sourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect {
    if (@available(iOS 8.0, *)) {
        if (self.alertController) {
            self.alertController.popoverPresentationController.sourceRect = sourceRect;
            self.alertController.popoverPresentationController.sourceView = sourceView;
            [viewController presentViewController:self.alertController animated:YES completion:nil];
        }
    } else if (self.actionSheet) {
        if (viewController.tabBarController) {
            [self.actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        } else {
            [self.actionSheet showInView:viewController.view];
        }
    } else if (self.alertView) {
        [self.alertView show];
    }
}

#pragma mark <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self removeFromSuperview];
    BDAlertAction *action = self.alertActions[buttonIndex];
    if (action.handler) {
        action.handler(action);
    }
}

#pragma mark <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self removeFromSuperview];
    BDAlertAction *action = self.alertActions[buttonIndex];
    if (action.handler) {
        action.handler(action);
    }
}

@end
