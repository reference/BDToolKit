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

NS_ASSUME_NONNULL_BEGIN

@interface BDAppStoreChecker : NSObject
/**
 * force update identifier.default is nil.If this define,when this word appear in the appupdate version info,the app will be force update
 */
@property (nonatomic, strong) NSString *forceUpdateIdentifier;
/**
 *  open APPStore inside your APP, default is No.
 */
@property (nonatomic, assign) BOOL openAPPStoreInsideAPP;
//  if you can't get the update info of your APP. Set countryAbbreviation of the sale area. like `countryAbbreviation = @"cn"`,`countryAbbreviation = @"us"`.General, you don't need to set this property.
@property (nonatomic, copy) NSString *countryAbbreviation;
/**
 *  get a singleton of the Check Manager
 */
+ (instancetype)sharedCheckManager;
/**
 *  start check version with default param.
 */
- (void)checkVersion;
/**
 *  start check version with AlertTitle,NextTimeTitle,ConfimTitle.
 */
- (void)checkVersionWithAlertTitle:(NSString *)alertTitle nextTimeTitle:(NSString *)nextTimeTitle confimTitle:(NSString *)confimTitle;
/**
 *  start check version with AlertTitle,NextTimeTitle,ConfimTitle,skipVersionTitle.
 */
- (void)checkVersionWithAlertTitle:(NSString *)alertTitle nextTimeTitle:(NSString *)nextTimeTitle confimTitle:(NSString *)confimTitle skipVersionTitle:(NSString *)skipVersionTitle;
@end

NS_ASSUME_NONNULL_END
