//
//  UIButton+BD.h
//  Spa
//
//  Created by B-A-N on 2019/7/6.
//  Copyright © 2019 scottban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIButton(BD)

- (void)addTarget:(nullable id)target action:(SEL )action forControlEvents:(UIControlEvents)controlEvents;

@end
