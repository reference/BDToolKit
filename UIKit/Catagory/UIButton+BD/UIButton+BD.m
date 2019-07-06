//
//  UIButton+BD.m
//  Spa
//
//  Created by B-A-N on 2019/7/6.
//  Copyright © 2019 scottban. All rights reserved.
//

#import "UIButton+BD.h"

@implementation UIButton(BD)

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    NSArray *actions = [self actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];

    for (NSString *ac in actions) {
        [self removeTarget:target action:NSSelectorFromString(ac) forControlEvents:controlEvents];
    }
    [super addTarget:target action:action forControlEvents:controlEvents];
}
@end
