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

@interface NSString(BD)
- (BOOL)isNumber; //是否数字
- (BOOL)isBankAccount; // 是否银行卡号
- (BOOL)hasChinese; // 是否包含中文
- (BOOL)isEmpty;
- (BOOL)isNotEmpty;
/**
 判断是否汉语非法字符
 
 非法字符是指 除数字 字母以外的所有字符
 @see https://blog.csdn.net/u013773524/article/details/51437327
 @return YES 有 NO 没有.
 */
- (BOOL)isIllegal;

- (NSString *)trim;


/// 是否正确手机号
- (BOOL)isIllegalPhoneNumber;

//date
- (NSDate *)dateWithFormat:(NSString *)format;
@end
