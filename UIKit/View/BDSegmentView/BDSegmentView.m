/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit BDButtonpersons to whom the Software is
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
#import "BDSegmentView.h"
@interface BDSegmentView()
@property (nonatomic, strong) UIView *underLine;
@end
@implementation BDSegmentView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (self.items) {
        NSArray *items = [self.items componentsSeparatedByString:@","];
        for (int i=0;i<items.count;i++) {
            NSString *item = items[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:item forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitleColor:self.normalItemColor?self.normalItemColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:self.selectedItemColor?self.selectedItemColor:[UIColor redColor] forState:UIControlStateSelected];
            btn.titleLabel.font = self.itemFont?self.itemFont:[UIFont systemFontOfSize:15];
            btn.tag = i;
            btn.selected = self.selectedIndex == i;
            btn.frame = CGRectMake(i*self.bounds.size.width/items.count, 0, self.bounds.size.width/items.count, self.bounds.size.height);
            [btn addTarget:self action:@selector(onSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        //underline
        self.underLine = [[UIView alloc] init];
        self.underLine.backgroundColor = self.underLineColor?self.underLineColor:[UIColor redColor];
        
        
        
        //width
        CGFloat width = 0;
        if (self.underLineWidth>0) {
            width = self.underLineWidth;
        }else{
            width = self.bounds.size.width/items.count;
        }
        
        //x
        CGFloat x = 0;
        if (self.underLineWidth>0) {
            x = self.bounds.size.width/items.count/2.f - width/2.f;
        }
        
        //y
        CGFloat y = self.bounds.size.height-(self.underLineHeight>0 ? self.underLineHeight : 1);
        
        self.underLine.frame = CGRectMake(x,y,
                                          width,
                                          self.underLineHeight>0?self.underLineHeight:1
                                          );
        [self addSubview:self.underLine];
    }
}

- (void)onSelectedButton:(UIButton *)btn
{
    //
    self.selectedIndex = btn.tag;
    
    //
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:UIButton.class]) {
            UIButton *b = (UIButton*)v;
            b.selected = NO;
        }
    }
    btn.selected = YES;
    if (self.selectedAtIndex) {
        self.selectedAtIndex(btn.tag);
    }
    
    //move underline
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.frame = CGRectMake(btn.frame.origin.x, self.underLine.frame.origin.y, self.underLine.bounds.size.width, self.underLine.bounds.size.height);
    
        self.underLine.frame = CGRectMake(btn.frame.origin.x + btn.bounds.size.width/2.f-self.underLine.bounds.size.width/2.f,
                                          self.underLine.frame.origin.y,
                                          self.underLine.bounds.size.width,
                                          self.underLine.bounds.size.height
                                          );
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
