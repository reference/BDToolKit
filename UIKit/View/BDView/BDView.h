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
#import "NSArray+BDUIKIT.h"

//IB_DESIGNABLE
@interface BDView : UIView<UITextFieldDelegate>
@property (nonatomic,strong) IBOutletCollection(UILabel) NSArray <UILabel *> *labels;
@property (nonatomic,strong) IBOutletCollection(UIImageView) NSArray <UIImageView *> *imageViews;
@property (nonatomic,strong) IBOutletCollection(UIView) NSArray <UIView *> *views;
@property (nonatomic,strong) IBOutletCollection(UIButton) NSArray <UIButton *> *buttons;
@property (nonatomic,strong) IBOutletCollection(UITextField) NSArray <UITextField *> *textFields;
@property (nonatomic,strong) IBOutletCollection(UITextView) NSArray <UITextView *> *textViews;
@property (nonatomic,strong) IBOutletCollection(UIStackView) NSArray <UIStackView *> *stackViews;
@property (nonatomic,strong) IBOutletCollection(UITableView) NSArray <UITableView *> *tableViews;
@property (nonatomic,strong) IBOutletCollection(BDView) NSArray <BDView *> *bd_views;
@property (nonatomic,assign) IBInspectable CGFloat radius;
//callback
@property (nonatomic,copy) void (^onClickedButtonsCallback)(UIButton *btn);

- (IBAction)onButtons:(UIButton *)btn;
@end
