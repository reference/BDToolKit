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
#import "NSError+LocalizedDescription.h"
#import <objc/runtime.h>

@implementation NSError (LocalizedDescription)

+ (void)swizzleMethod:(SEL)originalSelector with:(SEL)swizzledSelector {
    Class class = self;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSError swizzleMethod:@selector(localizedDescription) with:@selector(localizedDescription4ErrorDomain)];
    });
}

- (NSString *)localizedDescription4ErrorDomain {
    NSString *msg = [self localizedDescription4ErrorDomain];
    if (![[NSLocale preferredLanguages].firstObject hasPrefix:@"zh-Hans"]) {
        return msg;
    }
    switch (self.code) {
        case -1://NSURLErrorUnknown
            msg = @"未知错误";
            break;
        case -999://NSURLErrorCancelled
            msg = @"无效的URL地址";
            break;
        case -1000://NSURLErrorBadURL
            msg = @"无效的URL地址";
            break;
        case -1001://NSURLErrorTimedOut
            msg = @"网络超时，请稍后再试";
            break;
        case -1002://NSURLErrorUnsupportedURL
            msg = @"不支持的URL地址";
            break;
        case -1003://NSURLErrorCannotFindHost
            msg = @"找不到服务器";
            break;
        case -1004://NSURLErrorCannotConnectToHost
            msg = @"连接不上服务器";
            break;
        case -1103://NSURLErrorDataLengthExceedsMaximum
            msg = @"请求数据长度超出最大限度";
            break;
        case -1005://NSURLErrorNetworkConnectionLost
            msg = @"网络连接异常";
            break;
        case -1006://NSURLErrorDNSLookupFailed
            msg = @"DNS查询失败";
            break;
        case -1007://NSURLErrorHTTPTooManyRedirects
            msg = @"HTTP请求重定向";
            break;
        case -1008://NSURLErrorResourceUnavailable
            msg = @"资源不可用";
            break;
        case -1009://NSURLErrorNotConnectedToInternet
            msg = @"无网络连接";
            break;
        case -1010://NSURLErrorRedirectToNonExistentLocation
            msg = @"重定向到不存在的位置";
            break;
        case -1011://NSURLErrorBadServerResponse
            msg = @"服务器响应异常";
            break;
        case -1012://NSURLErrorUserCancelledAuthentication
            msg = @"用户取消授权";
            break;
        case -1013://NSURLErrorUserAuthenticationRequired
            msg = @"需要用户授权";
            break;
        case -1014://NSURLErrorZeroByteResource
            msg = @"零字节资源";
            break;
        case -1015://NSURLErrorCannotDecodeRawData
            msg = @"无法解码原始数据";
            break;
        case -1016://NSURLErrorCannotDecodeContentData
            msg = @"无法解码内容数据";
            break;
        case -1017://NSURLErrorCannotParseResponse
            msg = @"无法解析响应";
            break;
        case -1018://NSURLErrorInternationalRoamingOff
            msg = @"国际漫游关闭";
            break;
        case -1019://NSURLErrorCallIsActive
            msg = @"被叫激活";
            break;
        case -1020://NSURLErrorDataNotAllowed
            msg = @"数据不被允许";
            break;
        case -1021://NSURLErrorRequestBodyStreamExhausted
            msg = @"请求体";
            break;
        case -1100://NSURLErrorFileDoesNotExist
            msg = @"文件不存在";
            break;
        case -1101://NSURLErrorFileIsDirectory
            msg = @"文件是个目录";
            break;
        case -1102://NSURLErrorNoPermissionsToReadFile
            msg = @"无读取文件权限";
            break;
        case -1200://NSURLErrorSecureConnectionFailed
            msg = @"安全连接失败";
            break;
        case -1201://NSURLErrorServerCertificateHasBadDate
            msg = @"服务器证书失效";
            break;
        case -1202://NSURLErrorServerCertificateUntrusted
            msg = @"不被信任的服务器证书";
            break;
        case -1203://NSURLErrorServerCertificateHasUnknownRoot
            msg = @"未知Root的服务器证书";
            break;
        case -1204://NSURLErrorServerCertificateNotYetValid
            msg = @"服务器证书未生效";
            break;
        case -1205://NSURLErrorClientCertificateRejected
            msg = @"客户端证书被拒";
            break;
        case -1206://NSURLErrorClientCertificateRequired
            msg = @"需要客户端证书";
            break;
        case -2000://NSURLErrorCannotLoadFromNetwork
            msg = @"无法从网络获取";
            break;
        case -3000://NSURLErrorCannotCreateFile
            msg = @"无法创建文件";
            break;
        case -3001:// NSURLErrorCannotOpenFile
            msg = @"无法打开文件";
            break;
        case -3002://NSURLErrorCannotCloseFile
            msg = @"无法关闭文件";
            break;
        case -3003://NSURLErrorCannotWriteToFile
            msg = @"无法写入文件";
            break;
        case -3004://NSURLErrorCannotRemoveFile
            msg = @"无法删除文件";
            break;
        case -3005://NSURLErrorCannotMoveFile
            msg = @"无法移动文件";
            break;
        case -3006://NSURLErrorDownloadDecodingFailedMidStream
            msg = @"下载解码数据失败";
            break;
        case -3007://NSURLErrorDownloadDecodingFailedToComplete
            msg = @"下载解码数据失败";
            break;
    }
    NSHTTPURLResponse *response = self.userInfo[@"com.alamofire.serialization.response.error.response"];
    if ([response isKindOfClass:NSHTTPURLResponse.class]) {
        msg = [msg stringByAppendingFormat:@"(%d)", (int)response.statusCode];
    }
    return msg;
}

@end
