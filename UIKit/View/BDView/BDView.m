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

#import "BDView.h"

@implementation BDView

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (self.textFields.count) {
        for (UITextField *tf in self.textFields) {
            tf.delegate = self;
        }
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.radius = 0;
    }return self;
}

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (IBAction)onButtons:(UIButton *)btn
{
    if (self.onClickedButtonsCallback) {
        self.onClickedButtonsCallback(btn);
    }
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone || textField.returnKeyType == UIReturnKeyGo || textField.returnKeyType == UIReturnKeySend) {
        [textField resignFirstResponder];
    }
    if (textField.returnKeyType == UIReturnKeyNext) {
        for (UITextField *tf in self.textFields) {
            if (tf.tag == textField.tag+1) {
                [tf becomeFirstResponder];
                break;
            }
        }
    }
    return YES;
}
@end
