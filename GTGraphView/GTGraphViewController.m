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

@interface GTGraphViewController ()

@property (nonatomic, strong, readwrite) GTGraphView *graphView;
@property (nonatomic, assign, readwrite) GTGraphType graphType;

@property (nonatomic, strong) GTAxesView *axesView;

@end

#pragma mark - Implementation

@implementation GTGraphViewController

@synthesize graphView = _graphView;
@synthesize graphType = _graphType;

@synthesize axesView = _axesView;

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
    self.axesView = [[GTAxesView alloc] initWithFrame:self.view.bounds];
    self.graphView = [[GTLineChartView alloc] initWithFrame:self.axesView.scrollView.bounds];
    [self.axesView.scrollView addSubview:self.graphView];
    [self.view addSubview:self.axesView];
    self.graphView.dataSource = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - GTGraphViewDataSource

- (NSUInteger)numberOfValuesToDrawInGraphView:(GTGraphView *)graphView
{
    // TEST
    return 5;
}

- (NSArray *)graphObjectsForGraphView:(GTGraphView *)graphView
{
    // TEST
    return nil;
}

#pragma mark - GTGraphViewDelegate

- (void)didSelectGraphObject:(id<GTGraphObjectProtocol>)object inGraphView:(GTGraphView *)graphView
{
    NSLog(@"Did select object:%@ in graphView:%@", object, graphView);
}

@end
