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
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowRadius = 2.0f;
}

@end
