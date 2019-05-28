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
#import "NSString+BD.h"

@implementation NSString(BD)

- (BOOL)isNumber
{
    if (self == nil || [self length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![self isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}

- (BOOL)isBankAccount{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[self length];
    int lastNum = [[self substringFromIndex:cardNoLength-1] intValue];
    
    NSString *newSelf = [self substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [newSelf substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

- (BOOL)isEmpty
{
    if (self) {
        return self.length == 0;
    }return YES;
}

- (BOOL)isNotEmpty
{
    return ![self isEmpty];
}

- (BOOL)isIllegalPhoneNumber
{
    if (self && self.length>0) {
        /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 16[6], 17[5, 6, 7, 8], 18[0-9], 170[0-9], 19[89]
         * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
         * 联通号段: 130,131,132,155,156,185,186,145,175,176,1709,166
         * 电信号段: 133,153,180,181,189,177,1700,199
         */
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$";
        NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
        NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
        
        /**
         * 大陆地区固话及小灵通
         * 区号：010,020,021,022,023,024,025,027,028,029
         * 号码：七位或八位
         */
        // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
        
        if(([regextestmobile evaluateWithObject:self] == YES)
           || ([regextestcm evaluateWithObject:self] == YES)
           || ([regextestct evaluateWithObject:self] == YES)
           || ([regextestcu evaluateWithObject:self] == YES)) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

- (BOOL)hasChinese{
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isBTCValidAddress
{
    if (self) {
        //prefix
        //prefix
        if ([self hasPrefix:@"1"]) {
            //length
            if (self.length == 34) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)isETHValidAddress
{
    if (self) {
        if ([self hasPrefix:@"0x"]) {
            //length
            if (self.length == 42) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)isUSDTValidAddress
{
    if (self) {
        //prefix
        if ([self hasPrefix:@"1"]) {
            //length
            return YES;
        }
    }
    return NO;
}

- (BOOL)isIllegal
{
    NSString *str =@"^[A-Za-z0-9]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//date
- (NSDate *)dateWithFormat:(NSString *)format
{
    if (self) {
        //计算日期和天数
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        NSDate *timeDate = [dateFormatter dateFromString:self];
        return timeDate;
        //        //八小时时区
        //        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        //        NSInteger interval = [zone secondsFromGMTForDate:timeDate];
        //        return [timeDate dateByAddingTimeInterval:interval];
    }return nil;
}

@end
