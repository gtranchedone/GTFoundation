//
//  UIView+GTExtentions.m
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 12/03/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "UIView+GTExtentions.h"

@implementation UIView (GTExtentions)

- (void)addShadowWithOffset:(CGSize)offset
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowPath = shadowPath.CGPath;
    self.layer.shouldRasterize = YES;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = 0.8;
    self.layer.masksToBounds = NO;
    self.layer.shadowRadius = 3;
}

@end
