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
#import "WKWebView+MultiImages.h"

#define ContentUrlHeader @"<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title></title><style>*{margin:0;padding:0}img{border:0;display:block}#img_box img{width:100%}</style></head><body><div id=\"img_box\"></div></body><script type=\"text/javascript\">var thisBox=document.getElementById('img_box');var arr=["
#define ContentUrlTail @"];var html=''; for(var i=0;i<arr.length;i++){html+=\"<img src='\"+arr[i]+\"'>\"};thisBox.innerHTML=html;</script></html>"

@implementation WKWebView(MultiImages)

- (void)loadRemoteImageWithURLs:(NSArray <NSString *>*)urls
{
    //content
    NSMutableString *images = [NSMutableString string];
    for (NSString *img in urls) {
        [images appendFormat:@"\'%@\'",img];
        [images appendString:@","];
    }
    if (images.length) {
        [images deleteCharactersInRange:NSMakeRange(images.length-1, 1)];
    }
    
    [self loadHTMLString:[NSString stringWithFormat:@"%@%@%@",ContentUrlHeader,images,ContentUrlTail] baseURL:nil];
}
@end
