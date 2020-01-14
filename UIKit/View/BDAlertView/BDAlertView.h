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
#import <UIKit/UIKit.h>

/**
 BDAlertActionStyle
 */
typedef NS_ENUM(NSInteger, BDAlertActionStyle) {
    BDAlertActionStyleDefault = 0,
    BDAlertActionStyleCancel,
    BDAlertActionStyleDestructive
};

/**
 BDAlertAction
 */
@interface BDAlertAction : NSObject

/**
 Title for action
 */
@property (nonatomic, strong) NSString *title;
/**
 Style for action
 */
@property (nonatomic, assign) BDAlertActionStyle style;

/**
 Make an action

 @param title Title for action
 @param handler Handler for action
 @return Instance
 */
+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(BDAlertAction *action))handler;

/**
 Initialization

 @param title Title for action
 @param handler Handler for action
 @return Instance
 */
- (instancetype)initWithTitle:(NSString *)title handler:(void (^)(BDAlertAction *action))handler;

@end

/**
 BDAlertViewStyle
 */
typedef NS_ENUM(NSInteger, BDAlertViewStyle) {
    BDAlertViewStyleActionSheet = 0,
    BDAlertViewStyleAlert,
};

/**
 BDAlertView
 */
@interface BDAlertView : UIView
/**
 Title for alert view
 */
@property (nonatomic, readonly) NSString *title;
/**
 Message for alert view
 */
@property (nonatomic, readonly) NSString *message;
/**
 Style for alert view
 */
@property (nonatomic, readonly) BDAlertViewStyle style;

/**
 Like UIAlertView, compatible with iOS 7,8
 
 @param title Title for alert view
 @param message Message for alert view
 @param style UIAlertViewStyle for alert view
 @param cancelAction Cancel action, the style is UIAlertActionStyleCancel
 @param otherAction Other action, end with nil
 @return The alert view
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(BDAlertViewStyle)style cancelAction:(BDAlertAction *)cancelAction otherAction:(BDAlertAction *)otherAction, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Add action for alert view
 */
- (void)addAction:(BDAlertAction *)action;

/**
 All actions for alert view
 
 @return The actions
 */
@property (nonatomic, readonly) NSArray<BDAlertAction *> *actions;

/**
 Add UITextField for alert view

 @param configurationHandler configuration handler
 */
- (void)addTextField:(void (^)(UITextField *textField))configurationHandler;

/**
 All text fields for alert view

 @return The text fields
 */
@property (nonatomic, readonly) NSArray<UITextField *> *textFields;

/**
 Show the alertView
 
 @param viewController The parent view controller
 */
- (void)showInViewController:(UIViewController *)viewController;

/**
 Show the alertView
 
 @param viewController The parent view controller
 @param sourceView The source view for iPad
 */
- (void)showInViewController:(UIViewController *)viewController sourceView:(UIView *)sourceView;

/**
 Show the alertView
 
 @param viewController The parent view controller
 @param sourceView The source view for iPad
 @param sourceRect The source rect for iPad
 */
- (void)showInViewController:(UIViewController *)viewController sourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect;

@end
