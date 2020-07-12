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
#import "UITableViewHeaderFooterView+BDMasonryAutoFooterView.h"
#import <objc/runtime.h>

NSString *const kBDCacheUniqueKey = @"kBDCacheUniqueKey";
NSString *const kBDCacheStateKey = @"kBDCacheStateKey";
NSString *const kBDRecalculateForStateKey = @"kBDRecalculateForStateKey";
NSString *const kBDCacheForTableViewKey = @"kBDCacheForTableViewKey";

const void *s_bd_lastViewInCellKey = "bd_lastViewInCellKey";
const void *s_bd_bottomOffsetToCellKey = "bd_bottomOffsetToCellKey";

static const void *_bd_tableview_cacheFooterViewHeightKey = "_bd_tableview_cacheFooterViewHeightKey";
static const void *_bd_tableview_reuse_footerViews_key = "_bd_tableview_reuse_footerViews_key";

@implementation UITableView (BDCacheFooterViewHeight)

- (NSMutableDictionary *)bd_cacheFooterViewHeightDict {
    
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _bd_tableview_cacheFooterViewHeightKey);
    if (dict == nil) {
        dict = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self,
                                 _bd_tableview_cacheFooterViewHeightKey,
                                 dict,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dict;
    
}

- (NSMutableDictionary *)bd_reuseFooterViews {
    
    NSMutableDictionary *cells = objc_getAssociatedObject(self, _bd_tableview_reuse_footerViews_key);
    if (cells == nil) {
        cells = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self,
                                 _bd_tableview_reuse_footerViews_key,
                                 cells,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    
    return cells;
    
}
@end

@implementation UITableViewHeaderFooterView (BDMasonryAutoFooterViewHeight)

#pragma mark - Public
+ (CGFloat)bd_heightForTableView:(UITableView *)tableView config:(BDFooterViewBlock)config {
    UITableViewHeaderFooterView *cell = [tableView.bd_reuseFooterViews objectForKey:[[self class] description]];
    
    if (cell == nil) {
        cell = [[self alloc]initWithReuseIdentifier:nil];
        [tableView.bd_reuseFooterViews setObject:cell forKey:[[self class] description]];
    }
    
    if (config) {
        config(cell);
    }
    
    return [cell private_bd_heightForTableView:tableView];
}

+ (CGFloat)bd_heightForTableView:(UITableView *)tableView
                          config:(BDFooterViewBlock)config
                           cache:(BDCacheHeight)cache {
    if (cache) {
        NSDictionary *cacheKeys = cache();
        NSString *key = cacheKeys[kBDCacheUniqueKey];
        NSString *stateKey = cacheKeys[kBDCacheStateKey];
        NSString *shouldUpdate = cacheKeys[kBDRecalculateForStateKey];
        
        NSMutableDictionary *stateDict = tableView.bd_cacheFooterViewHeightDict[key];
        NSString *cacheHeight = stateDict[stateKey];
        
        if (tableView == nil || tableView.bd_cacheFooterViewHeightDict.count == 0 || shouldUpdate.boolValue || cacheHeight == nil) {
            CGFloat height = [self bd_heightForTableView:tableView config:config];
            
            if (stateDict == nil) {
                stateDict = [[NSMutableDictionary alloc] init];
                tableView.bd_cacheFooterViewHeightDict[key] = stateDict;
            }
            
            [stateDict setObject:[NSString stringWithFormat:@"%lf", height] forKey:stateKey];
            
            return height;
        } else if (tableView.bd_cacheFooterViewHeightDict.count != 0
                   && cacheHeight != nil
                   && cacheHeight.integerValue != 0) {
            return cacheHeight.floatValue;
        }
    }
    
    return [self bd_heightForTableView:tableView config:config];
}

-(void)setBd_lastViewInView:(UIView *)bd_lastViewInView{
    objc_setAssociatedObject(self,
                             s_bd_lastViewInCellKey,
                             bd_lastViewInView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)bd_lastViewInView{
    return objc_getAssociatedObject(self, s_bd_lastViewInCellKey);
}

- (void)setBd_bottomOffsetToView:(CGFloat)bd_bottomOffsetToView{
    objc_setAssociatedObject(self,
                             s_bd_bottomOffsetToCellKey,
                             @(bd_bottomOffsetToView),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)bd_bottomOffsetToView{
    NSNumber *valueObject = objc_getAssociatedObject(self, s_bd_bottomOffsetToCellKey);
    
    if ([valueObject respondsToSelector:@selector(floatValue)]) {
        return valueObject.floatValue;
    }
    
    return 0.0;
}

#pragma mark - Private
- (CGFloat)private_bd_heightForTableView:(UITableView *)tableView {
    NSAssert(self.bd_lastViewInView != nil, @"您未指定cell排列中最后一个视图对象，无法计算cell的高度");
    
    [self layoutIfNeeded];
    
    CGFloat rowHeight = self.bd_lastViewInView.frame.size.height + self.bd_lastViewInView.frame.origin.y;
    rowHeight += self.bd_bottomOffsetToView;
    
    return rowHeight;
}
@end
