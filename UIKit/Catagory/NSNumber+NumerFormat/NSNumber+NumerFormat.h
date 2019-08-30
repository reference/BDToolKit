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

@interface NSNumber(NumerFormat)

/**
 Format number

 @param format format such as ###,###.###
 @return formated string
 */
- (NSString *_Nullable)stringWithFormat:(NSString *)format;

/**
 Format number

 @param format format
 @param allow allowZerosAfterDecimalPoint default NO
 @return formated string
 */
- (NSString *)stringWithFormat:(NSString *)format allowZerosAfterDecimalPoint:(BOOL)allow;

/**
 Format number

 @param format format
 @param block block
 @return formated string
 */
- (NSString *)stringWithFormat:(NSString *)format block:(nullable void (^)(NSNumberFormatter *fmt))block;


/**
 Keep decimals, not rounding

 @param position position
 @return not rounding number string
 */
-(NSString *_Nullable)notRoundingAfterPoint:(int)position;
@end
