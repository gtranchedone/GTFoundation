//
//  GTGraphView.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 16/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GTGraphObject.h"

extern NSString * const GTGraphViewObjectWasSelectedNotification;

@protocol GTGraphViewDataSource;
@protocol GTGraphViewDelegate;

@interface GTGraphView : UIView

@property (nonatomic, assign) id<GTGraphViewDataSource> dataSource;
@property (nonatomic, assign) id<GTGraphViewDelegate> delegate;

@end

// GTGraphViewDataSource

@protocol GTGraphViewDataSource <NSObject>

- (NSUInteger)numberOfObjectsToDrawInGraphView:(GTGraphView *)graphView;
- (GTGraphObject *)graphView:(GTGraphView *)graphView objectAtIndex:(NSUInteger)index;

@end

// GTGraphViewDelegate

@protocol GTGraphViewDelegate <NSObject>

@optional
- (void)graphView:(GTGraphView *)graphView didSelectGraphObject:(GTGraphObject *)object;

@end
