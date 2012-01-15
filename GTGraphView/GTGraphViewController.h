//
//  GTGraphViewController.h
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

/**
 * @class GTGraphViewController is a viewController which takes care of displaying data in the form of a graph. The graph type is one of the 
 * @enum GTGraphType defined below. @class GTGraphViewController is intented to be inizialized using it's default initializer
 * -initWithGraphType:. If a @class GTGraphViewController is initialized with a metod different from it's default inizializer or is added
 * in a XIB / Storyboard file, it will be initialized as a GTGraphTypeLineChart graph.
 * The data provided to the controller via the @protocol GTGraphViewDataSource is automatically formatted to be displayed in the choosen 
 * graph type.
 */

#import <UIKit/UIKit.h>

typedef enum
{
    GTGraphTypePieChart,
    GTGraphTypeLineChart,
    GTGraphTypeVerticalBars,
    GTGraphTypeHorizontalBars // not implemented yet
} GTGraphType;

@protocol GTGraphViewDataSource;
@protocol GTGraphViewDelegate;

@interface GTGraphViewController : UIViewController

@property (nonatomic, assign) id<GTGraphViewDataSource> dataSource;
@property (nonatomic, assign) id<GTGraphViewDelegate> delegate;

@property (nonatomic, assign, readonly) GTGraphType graphType;

- (id)initWithGraphType:(GTGraphType)graphType; // default initializer

@end

// GTGraphViewDataSource

@protocol GTGraphViewDataSource <NSObject>

- (NSUInteger)numberOfValuesToDrawInGraphView:(GTGraphViewController *)graphView;

@end
