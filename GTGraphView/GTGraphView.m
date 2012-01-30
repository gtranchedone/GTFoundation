//
//  GTGraphView.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 16/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTGraphView.h"

NSString * const GTGraphViewObjectWasSelectedNotification = @"GTGraphViewObjectWasSelectedNotification";

@interface GTGraphView ()

- (void)objectWasSelected:(NSNotification *)notification;

@end

@implementation GTGraphView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(objectWasSelected:) 
                                                     name:GTGraphViewObjectWasSelectedNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    [self setNeedsDisplay];
}

- (void)objectWasSelected:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[GTGraphObject class]]) {
        if ([self.delegate respondsToSelector:@selector(graphView:didSelectGraphObject:)]) {
            [self.delegate graphView:self didSelectGraphObject:notification.object];
        }
    }
}

@end
