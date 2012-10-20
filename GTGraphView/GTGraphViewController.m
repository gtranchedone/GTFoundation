//
//  GTGraphViewController.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTGraphViewController.h"

#import "GTAxesView.h"
#import "GTLineChartView.h"

@interface GTGraphViewController ()

@property (nonatomic, strong, readwrite) GTGraphView *graphView;
@property (nonatomic, assign, readwrite) GTGraphType graphType;

@property (nonatomic, strong) GTAxesView *axesView;
@property (nonatomic, assign) BOOL shouldDisplayAxes;

@end

#pragma mark - Implementation

@implementation GTGraphViewController

@synthesize graphView = _graphView;
@synthesize graphType = _graphType;

@synthesize axesView = _axesView;
@synthesize shouldDisplayAxes = _shouldDisplayAxes;

#pragma mark - Initialization

- (id)init
{
    return [self initWithGraphType:GTGraphTypeLineChart];
}

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
    
    if (self.graphType == GTGraphTypeLineChart || self.graphType == GTGraphTypeVerticalBars) {
        self.shouldDisplayAxes = YES;
    }
}

#pragma mark - Custom Setters and Getters

- (GTGraphView *)graphView
{
    if (!_graphView) {
        switch (self.graphType) {
            case GTGraphTypeLineChart:
                _graphView = [[GTLineChartView alloc] initWithFrame:self.axesView.scrollView.bounds];
                break;
                
            default:
                _graphView = [[GTLineChartView alloc] initWithFrame:self.axesView.scrollView.bounds];
                break;
        }
        
        _graphView.dataSource = self;
        _graphView.delegate = self;
    }
    
    return _graphView;
}

- (GTAxesView *)axesView
{
    if (!_axesView) {
        _axesView = [[GTAxesView alloc] initWithFrame:self.view.bounds];
    }
    
    return _axesView;
}

- (void)setShouldDisplayAxes:(BOOL)shouldDisplayAxes
{
    _shouldDisplayAxes = shouldDisplayAxes;
    
    if (_shouldDisplayAxes) {
        [self.axesView.scrollView addSubview:self.graphView];
        [self.view addSubview:self.axesView];
    }
}

#pragma mark - GTGraphViewDataSource

- (NSUInteger)numberOfObjectsToDrawInGraphView:(GTGraphView *)graphView
{
    // To be overridden in a subclass
    return 0;
}

- (GTGraphObject *)graphView:(GTGraphView *)graphView objectAtIndex:(NSUInteger)index
{
    // To be overridden in a subclass
    return nil;
}

#pragma mark - GTGraphViewDelegate

- (void)graphView:(GTGraphView *)graphView didSelectGraphObject:(GTGraphObject *)object
{
    // To be overridden in a subclass
}

@end
