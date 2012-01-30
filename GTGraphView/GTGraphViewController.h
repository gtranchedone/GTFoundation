//
//  GTGraphViewController.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

/**
 @class GTGraphViewController is a viewController which takes care of displaying data in the form of a graph. The graph type is one of the 
 @enum GTGraphType defined below. @class GTGraphViewController is intented to be subclassed for use by overriding the implementations of
 the @protocol GTGraphViewDataSource and those of the @protocol GTGraphViewDelegate. @class GTGraphViewController's subclasses should be
 inizialized using it's default initializer -initWithGraphType:. If a @class GTGraphViewController is initialized with a metod different 
 from it's default inizializer or is added in a XIB / Storyboard file, it will be initialized as a GTGraphTypeLineChart graph.
 The data provided to the controller via the @protocol GTGraphViewDataSource is automatically formatted for displaying.
 */

#import <UIKit/UIKit.h>
#import "GTGraphView.h"

typedef enum
{
    GTGraphTypePieChart,
    GTGraphTypeLineChart, // default
    GTGraphTypeVerticalBars,
    GTGraphTypeHorizontalBars // not implemented yet
} GTGraphType;

@interface GTGraphViewController : UIViewController <GTGraphViewDataSource, GTGraphViewDelegate>

@property (nonatomic, strong, readonly) GTGraphView *graphView;
@property (nonatomic, assign, readonly) GTGraphType graphType;

- (id)initWithGraphType:(GTGraphType)graphType; // default initializer

@end
