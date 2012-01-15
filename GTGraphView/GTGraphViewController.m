//
//  GTGraphViewController.m
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTGraphViewController.h"

#import "GTAxesView.h"
#import "GTLineChartView.h"

@interface GTGraphViewController () <GTLineChartViewDataSource, GTLineChartViewDelegate>

@property (nonatomic, assign, readwrite) GTGraphType graphType;

@end

#pragma mark - Implementation

@implementation GTGraphViewController

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

@synthesize graphType = _graphType;

#pragma mark - Initialization

- (id)initWithGraphType:(GTGraphType)graphType
{
    self = [super init];
    if (self) {
        self.graphType = graphType;
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"GTGraphView";
    
    // TODO: get the source data and format it for the choosen graph type
    // TODO: create and add the correct graph view on top of this one
    
    // Test
    GTAxesView *axesView = [[GTAxesView alloc] initWithFrame:self.view.bounds];
    GTLineChartView *lineChartView = [[GTLineChartView alloc] initWithFrame:axesView.scrollView.bounds];
    [axesView.scrollView addSubview:lineChartView];
    [self.view addSubview:axesView];
    lineChartView.dataSource = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    for (UIView *view in self.view.subviews) {
        [view setNeedsDisplay];
        
        if ([view isMemberOfClass:[GTAxesView class]]) {
            for (UIView *subview in [(GTAxesView *)view scrollView].subviews) {
                [subview setNeedsDisplay];
            }
        }
    }
}

#pragma mark - GTLineChartViewDataSource

- (NSUInteger)numberOfPointsInChart:(GTLineChartView *)chart
{
    return 5;
}

@end
