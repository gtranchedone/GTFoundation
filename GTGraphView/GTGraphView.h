//
//  GTGraphView.h
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 16/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GTGraphObjectProtocol.h"

@protocol GTGraphViewDataSource;
@protocol GTGraphViewDelegate;

@interface GTGraphView : UIView

@property (nonatomic, assign) id<GTGraphViewDataSource> dataSource;
@property (nonatomic, assign) id<GTGraphViewDelegate> delegate;

@end

// GTGraphViewDataSource

@protocol GTGraphViewDataSource <NSObject>

- (NSUInteger)numberOfValuesToDrawInGraphView:(GTGraphView *)graphView;
- (NSArray *)graphObjectsForGraphView:(GTGraphView *)graphView;

@end

// GTGraphViewDelegate

@protocol GTGraphViewDelegate <NSObject>

@optional
- (void)didSelectGraphObject:(id<GTGraphObjectProtocol>)object inGraphView:(GTGraphView *)graphView;

@end
