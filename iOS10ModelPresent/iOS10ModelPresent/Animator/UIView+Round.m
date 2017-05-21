//
//  UIView+Round.m
//  iOS10ModelPresent
//
//  Created by SlowWalker on 21/05/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import "UIView+Round.h"

@implementation UIView (Round)

- (void)roundAt:(UIRectCorner)corners withRadius:(CGFloat)radius {

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.path = path.CGPath;
    self.layer.mask = mask;

}

@end
