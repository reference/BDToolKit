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
#import "BDView.h"
#import "BDStackView.h"
#import "NSObject+Identifier.h"

@interface NSArray(BDUIKIT)

//tag
- (UILabel *)labelForTag:(NSInteger )tag;
- (UIButton *)buttonForTag:(NSInteger )tag;
- (UITextField *)textFieldForTag:(NSInteger )tag;
- (UIImageView *)imageViewForTag:(NSInteger )tag;
- (UISwitch *)switchForTag:(NSInteger )tag;
- (UITableView *)tableViewForTag:(NSInteger )tag;
- (UICollectionView *)collectionViewForTag:(NSInteger )tag;
- (UICollectionReusableView *)collectionReusableViewForTag:(NSInteger )tag;
- (UIStackView *)stackViewForTag:(NSInteger )tag;
- (UIView *)viewForTag:(NSInteger )tag;

- (BDStackView *)bd_stackViewForTag:(NSInteger )tag;
- (BDView *)bd_viewForTag:(NSInteger )tag;

//identifier
- (UILabel *)labelForIdentifier:(NSString *)identifier;
- (UIButton *)buttonForIdentifier:(NSString *)identifier;
- (UITextField *)textFieldForIdentifier:(NSString *)identifier;
- (UIImageView *)imageViewForIdentifier:(NSString *)identifier;
- (UISwitch *)switchForIdentifier:(NSString *)identifier;
- (UITableView *)tableViewForIdentifier:(NSString *)identifier;
- (UICollectionView *)collectionViewForIdentifier:(NSString *)identifier;
- (UICollectionReusableView *)collectionReusableViewForIdentifier:(NSString *)identifier;
- (UIStackView *)stackViewForIdentifier:(NSString *)identifier;
- (UIView *)viewForIdentifier:(NSString *)identifier;

- (BDStackView *)bd_stackViewForIdentifier:(NSString *)identifier;
- (BDView *)bd_viewForIdentifier:(NSString *)identifier;
@end
