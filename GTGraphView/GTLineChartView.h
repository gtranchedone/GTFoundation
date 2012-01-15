//
//  GTLineChartView.h
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GTLineChartViewDataSource;
@protocol GTLineChartViewDelegate;

@class GTLineChartPoint;

@interface GTLineChartView : UIView

@property (nonatomic, assign) id<GTLineChartViewDataSource> dataSource;
@property (nonatomic, assign) id<GTLineChartViewDelegate> delegate;

@end

// GTLineChartViewDataSource

@protocol GTLineChartViewDataSource <NSObject>

- (NSUInteger)numberOfPointsInChart:(GTLineChartView *)chart;

@end

// GTLineChartViewDelegate

@protocol GTLineChartViewDelegate <NSObject>

// TODO

@end

/*** GTLineChartPoint ***/

@interface GTLineChartPoint : UIView

@property (nonatomic, copy) NSString *title;

@end
