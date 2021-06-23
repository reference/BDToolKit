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
#import "BDWebJsonRequester.h"

@implementation BDWebJsonRequester

- (id)init
{
    if (self = [super init]) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.navigationDelegate = self;
    }return self;
}

+ (void)requestWithUrl:(NSString *)url inView:(UIView *)view
{
    BDWebJsonRequester *sm = [BDWebJsonRequester new];
    [sm.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [view addSubview:sm];
    sm.frame = view.frame;
    sm.alpha = 0;
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSString *doc = @"document.body.outerHTML";
    [_webView evaluateJavaScript:doc
                     completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
        if (error) {
           //NSLog(@"JSError:%@",error);
            if (self.completion) {
                self.completion(nil, error);
            }
        }else{
            //使用正则表达式 <.*?> 获得所有标签 去掉所有标签 只留下json字符串
            NSString *regex = @"<.*?>";
            
            NSError *error = NULL;
            NSRegularExpression *regexE = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
            if (!error) {
                //获得所有html标签
                NSArray *result = [regexE matchesInString:htmlStr options:0 range:NSMakeRange(0, [htmlStr length])];
                if (result.count > 0) {
                    NSMutableString *tempHtmlStr = [NSMutableString stringWithString:htmlStr];
                    for (NSTextCheckingResult *textCheckingResult in result) {
                        NSString *matchStr = [htmlStr substringWithRange:textCheckingResult.range];
                        tempHtmlStr = [tempHtmlStr stringByReplacingOccurrencesOfString:matchStr withString:@""];
                    }
                      //json数据当中没有 \n \r \t 等制表符，当后台给出有问题时，我们需要对json数据过滤
                    tempHtmlStr = [tempHtmlStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
                    tempHtmlStr = [tempHtmlStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    tempHtmlStr = [tempHtmlStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                    //NSData *utf8Data = [tempHtmlStr dataUsingEncoding:NSUTF8StringEncoding];
                  
                    if (self.completion) {
                        self.completion(tempHtmlStr, nil);
                    }
                }else{
                    if (self.completion) {
                        self.completion(nil, [NSError errorWithDomain:NSURLErrorDomain code:100001 userInfo:@{NSLocalizedDescriptionKey:@"no data found"}]);
                    }
                }
            } else {
                //NSLog(@"Error: %@", error.localizedDescription);
                if (self.completion) {
                    self.completion(nil, error);
                }
            }
        }
        
        [self removeFromSuperview];
    }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    if (self.completion) {
        self.completion(nil, error);
    }
    [self removeFromSuperview];
}
@end
