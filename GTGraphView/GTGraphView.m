//
//  GTGraphView.m
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 16/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTGraphView.h"

@implementation GTGraphView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

- (void)layoutSubviews
{
    [self setNeedsDisplay];
}

@end
