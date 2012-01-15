//
//  GTLineChartView.m
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTLineChartView.h"

#define PointsSize 15
#define LineWidth 4

#pragma mark - GTLineChartPoint Implementation

@implementation GTLineChartPoint

@synthesize title = _title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin |
                                 UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin);
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGColorRef color = [UIColor lightSeaGreenColor].CGColor;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetFillColorWithColor(context, color);
    
    CGContextAddArc(context, self.bounds.size.width / 2, self.bounds.size.height / 2, (self.bounds.size.width / 2) - 2, 0.0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    CGContextRestoreGState(context);
}

@end

#pragma mark - GTLineChartView Implementation

@interface GTLineChartView ()

@property (nonatomic, strong) NSArray *pointsArray;

- (void)initialSetup;

@end

#pragma mark - Implementation

@implementation GTLineChartView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

@synthesize pointsArray = _pointsArray;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
        [self initialSetup];
    }
    return self;
}

- (void)initialSetup
{
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    if (self.pointsArray) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        CGContextSetLineWidth(context, LineWidth);
        CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
        
        CGContextMoveToPoint(context, 0.0, self.bounds.size.height);
        
        for (GTLineChartPoint *point in self.pointsArray) {
            CGContextAddLineToPoint(context, point.center.x, point.center.y);
        }
        
        CGContextDrawPath(context, kCGPathStroke);
        
        CGContextRestoreGState(context);
    }
}

#pragma mark - Custom Setters And Getters

- (void)setDataSource:(id<GTLineChartViewDataSource>)dataSource
{
    _dataSource = dataSource;
    
    // Test
    CGPoint point1 = CGPointMake(50, 100);
    CGPoint point2 = CGPointMake(100, 200);
    CGPoint point3 = CGPointMake(150, 150);
    
    GTLineChartPoint *Point1 = [[GTLineChartPoint alloc] initWithFrame:(CGRect){point1, PointsSize, PointsSize}];
    GTLineChartPoint *Point2 = [[GTLineChartPoint alloc] initWithFrame:(CGRect){point2, PointsSize, PointsSize}];
    GTLineChartPoint *Point3 = [[GTLineChartPoint alloc] initWithFrame:(CGRect){point3, PointsSize, PointsSize}];
    
    self.pointsArray = [NSArray arrayWithObjects:Point1, Point2, Point3, nil];
    
    [self setNeedsDisplay];
    
    [self addSubview:Point1];
    [self addSubview:Point2];
    [self addSubview:Point3];
}

@end
