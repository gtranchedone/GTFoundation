//
//  GTLineChartView.m
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTLineChartView.h"

#define LineWidth 4.0
#define PointsSize CGSizeMake(15.0, 15.0)
#define LineChartXAxisMargin 50
#define LineChartYAxisMargin 10

#pragma mark - GTLineChartPoint Interface

@interface GTLineChartPoint : UIView

@property (nonatomic, strong) GTGraphObject *graphObject;

@end

#pragma mark - GTLineChartView Implementation

@interface GTLineChartView ()

@property (nonatomic, strong) NSArray *graphObjects;

- (void)loadGraphObjects;

@end

#pragma mark - Implementation

@implementation GTLineChartView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

@synthesize graphObjects = _graphObjects;

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    if (self.graphObjects) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        CGContextSetLineWidth(context, LineWidth);
        CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
        CGContextSetLineJoin(context, kCGLineJoinBevel);
        
        BOOL begin = YES;
        
        for (GTLineChartPoint *point in self.subviews) {
            if ([point isMemberOfClass:[GTLineChartPoint class]]) {
                if (begin) {
                    begin = NO;
                    CGContextMoveToPoint(context, 0.0, point.center.y);
                } else {
                    CGContextAddLineToPoint(context, point.center.x, point.center.y);
                }
            }
        }
        
        CGContextDrawPath(context, kCGPathStroke);
        
        CGContextRestoreGState(context);
    }
}

#pragma mark - Custom Setters And Getters

- (void)setDataSource:(id<GTGraphViewDataSource>)dataSource
{
    _dataSource = dataSource;
    
    // get the number of items
    [self loadGraphObjects];
}

- (void)loadGraphObjects
{
    NSUInteger numberOfObjects = [self.dataSource numberOfObjectsToDrawInGraphView:self];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:numberOfObjects];
    
    for (int i = 0; i < numberOfObjects; i++) {
        // get the items and put them in an array
        GTGraphObject *graphObject = [self.dataSource graphView:self objectAtIndex:i];
        [mutableArray addObject:graphObject];
        
        // create lineChartPoints for each iteam and add them as subviews of the view
        CGFloat yValue = (graphObject.value * self.bounds.size.height); // get the value a point on the screen (iOS cordinate system)
        yValue = self.bounds.size.height - yValue; // get the value in the lineChart coordinate system.
        
        CGPoint graphPointOrigin = CGPointMake(LineChartXAxisMargin * i, yValue);
        GTLineChartPoint *graphPoint = [[GTLineChartPoint alloc] initWithFrame:(CGRect){graphPointOrigin, PointsSize}];
        [self addSubview:graphPoint];
    }
    
    self.graphObjects = [NSArray arrayWithArray:mutableArray];
}

@end

#pragma mark - GTLineChartPoint Implementation

@implementation GTLineChartPoint

@synthesize graphObject = _graphObject;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIColor *color = [UIColor lightSeaGreenColor];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextAddArc(context, self.bounds.size.width / 2, self.bounds.size.height / 2, (self.bounds.size.width / 2) - 1, 0.0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    CGContextRestoreGState(context);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:GTGraphViewObjectWasSelectedNotification object:self.graphObject];
}

@end
