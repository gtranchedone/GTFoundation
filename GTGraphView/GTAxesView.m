//
//  GTAxesView.m
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTAxesView.h"

#define OriginDistance 50
#define LineWidth 2

@interface GTAxesView () <UIScrollViewDelegate>

@property (nonatomic, assign) CGPoint endPoint;

- (void)initialSetup;

@end

#pragma mark - Implementation

@implementation GTAxesView

@synthesize origin = _origin;
@synthesize scrollView = _scrollView;

@synthesize endPoint = _endPoint;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSetup];
    }
    return self;
}

- (void)initialSetup
{
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    [self addSubview:self.scrollView];
    
    // TODO: add scollViews for axes labels 
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // draw 'x' axis
    CGPoint endPoint = CGPointMake(self.bounds.size.width - (OriginDistance / 2), self.origin.y);
    self.endPoint = CGPointMake(endPoint.x, 0.0);

    CGContextMoveToPoint(context, endPoint.x, endPoint.y);
    CGContextAddLineToPoint(context, self.origin.x - (LineWidth / 2), self.origin.y);
    
    // draw 'x' axis triangle
    float lenght = 5;
    CGContextMoveToPoint(context, endPoint.x, endPoint.y - (lenght / 2));
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y + (lenght / 2));
    CGContextAddLineToPoint(context, endPoint.x + lenght, endPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y - (lenght / 2));
    
    // draw 'y' axis
    endPoint = CGPointMake(self.origin.x, (OriginDistance / 2));
    self.endPoint = CGPointMake(self.endPoint.x, endPoint.y);
    
    CGContextMoveToPoint(context, endPoint.x, endPoint.y);
    CGContextAddLineToPoint(context, self.origin.x, self.origin.y + (LineWidth / 2));
    
    // draw 'x' axis triangle
    CGContextMoveToPoint(context, endPoint.x - (lenght / 2), endPoint.y);
    CGContextAddLineToPoint(context, endPoint.x + (lenght / 2), endPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y - lenght);
    CGContextAddLineToPoint(context, endPoint.x - (lenght / 2), endPoint.y);
    
    // draw the lines
    CGContextSetLineWidth(context, LineWidth);
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextRestoreGState(context);
}

- (void)layoutSubviews
{
    [self setNeedsDisplay];
}

#pragma mark - UIScrollViewDelegate

// TODO

#pragma mark - Custom Setters and Getters

- (CGPoint)origin
{
    return CGPointMake(OriginDistance, self.bounds.size.height - OriginDistance);
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        CGSize size = CGSizeMake(self.bounds.size.width - self.origin.x - (OriginDistance / 2), 
                                 self.bounds.size.height - (OriginDistance * 2) - (LineWidth / 2));
        
        _scrollView = [[UIScrollView alloc] initWithFrame:(CGRect){self.origin.x + (LineWidth / 2), OriginDistance, size}];
        _scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

@end
