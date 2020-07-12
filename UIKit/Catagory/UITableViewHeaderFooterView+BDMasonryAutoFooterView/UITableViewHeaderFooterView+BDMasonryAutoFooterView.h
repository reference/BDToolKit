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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BDFooterViewBlock)(UITableViewHeaderFooterView *sourceView);

typedef NSDictionary *_Nullable(^BDCacheHeight)(void);

FOUNDATION_EXTERN NSString *const kBDCacheUniqueKey;

FOUNDATION_EXTERN NSString *const kBDCacheStateKey;

FOUNDATION_EXTERN NSString *const kBDRecalculateForStateKey;

@interface UITableView (BDCacheFooterViewHeight)

@property (nonatomic, strong, readonly) NSMutableDictionary *bd_cacheFooterViewHeightDict;

@property (nonatomic, strong, readonly) NSMutableDictionary *bd_reuseFooterViews;
@end

/// auto layout footer view for tableview
@interface UITableViewHeaderFooterView (BDMasonryAutoFooterViewHeight)

@property (nonatomic, strong) UIView *bd_lastViewInView;

@property (nonatomic, assign) CGFloat bd_bottomOffsetToView;

+ (CGFloat)bd_heightForTableView:(UITableView *)tableView config:(BDFooterViewBlock)config;

+ (CGFloat)bd_heightForTableView:(UITableView *)tableView
                           config:(BDFooterViewBlock)config
                            cache:(BDCacheHeight)cache;
@end

NS_ASSUME_NONNULL_END
