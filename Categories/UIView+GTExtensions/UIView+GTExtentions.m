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
    [self addShadowWithOffset:offset toLayer:self.layer];
}

- (void)addShadowWithOffset:(CGSize)offset toLayer:(CALayer *)layer
{
    layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = offset;
    layer.shadowOpacity = 0.5f;
    layer.shadowRadius = 2.0f;
}

@end
