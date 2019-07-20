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
#import "NSArray+BDUIKIT.h"

@implementation NSArray(BDUIKIT)
#pragma mark - tag
- (UILabel *)labelForTag:(NSInteger )tag
{
    return (UILabel *)[self viewForTag:tag];
}

- (UIButton *)buttonForTag:(NSInteger )tag
{
    return (UIButton *)[self viewForTag:tag];
}

- (UIImageView *)imageViewForTag:(NSInteger )tag
{
    return (UIImageView *)[self viewForTag:tag];
}

- (UITextField *)textFieldForTag:(NSInteger )tag
{
    return (UITextField *)[self viewForTag:tag];
}

- (UISwitch *)switchForTag:(NSInteger )tag
{
    return (UISwitch *)[self viewForTag:tag];
}

- (UITableView *)tableViewForTag:(NSInteger )tag
{
    return (UITableView *)[self viewForTag:tag];
}

- (UICollectionView *)collectionViewForTag:(NSInteger )tag
{
    return (UICollectionView *)[self viewForTag:tag];
}

- (UICollectionReusableView *)collectionReusableViewForTag:(NSInteger )tag
{
    return (UICollectionReusableView *)[self viewForTag:tag];
}

- (UIStackView *)stackViewForTag:(NSInteger )tag
{
    return (UIStackView *)[self viewForTag:tag];
}

- (BDStackView *)bd_stackViewForTag:(NSInteger )tag
{
    return (BDStackView *)[self viewForTag:tag];
}

- (BDView *)bd_viewForTag:(NSInteger )tag
{
    return (BDView *)[self viewForTag:tag];
}

- (UIView *)viewForTag:(NSInteger )tag
{
    for (UIView *v in self) {
        if (v.tag == tag) {
            return v;
        }
    }
    return nil;
}

#pragma mark - identifier

- (UILabel *)labelForIdentifier:(NSString *)identifier
{
    return (UILabel *)[self viewForIdentifier:identifier];
}

- (UIButton *)buttonForIdentifier:(NSString *)identifier
{
    return (UIButton *)[self viewForIdentifier:identifier];
}

- (UIImageView *)imageViewForIdentifier:(NSString *)identifier
{
    return (UIImageView *)[self viewForIdentifier:identifier];
}

- (UITextField *)textFieldForIdentifier:(NSString *)identifier
{
    return (UITextField *)[self viewForIdentifier:identifier];
}

- (UISwitch *)switchForIdentifier:(NSString *)identifier
{
    return (UISwitch *)[self viewForIdentifier:identifier];
}

- (UITableView *)tableViewForIdentifier:(NSString *)identifier
{
    return (UITableView *)[self viewForIdentifier:identifier];
}

- (UICollectionView *)collectionViewForIdentifier:(NSString *)identifier
{
    return (UICollectionView *)[self viewForIdentifier:identifier];
}

- (UICollectionReusableView *)collectionReusableViewForIdentifier:(NSString *)identifier
{
    return (UICollectionReusableView *)[self viewForIdentifier:identifier];
}

- (UIStackView *)stackViewForIdentifier:(NSString *)identifier
{
    return (UIStackView *)[self viewForIdentifier:identifier];
}

- (BDStackView *)bd_stackViewForIdentifier:(NSString *)identifier
{
    return (BDStackView *)[self viewForIdentifier:identifier];
}

- (BDView *)bd_viewForIdentifier:(NSString *)identifier
{
    return (BDView *)[self viewForIdentifier:identifier];
}

- (UIView *)viewForIdentifier:(NSString *)identifier;
{
    for (UIView *v in self) {
        if ([v.identifier isEqualToString:identifier]) {
            return v;
        }
    }
    return nil;
}
@end
