//
//  GTPagingView.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 11/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

/**
 This view provides his user with a view made of a pagingEnabled scrollView and a pageControl.
 The content of each page is loaded lazily when the user moves from one page to another.
 
 N.B. The current implementation of this class, only supports horizontal pagination and doesn't support reuse of pages.
 */

#import <UIKit/UIKit.h>

@protocol GTPagingViewDataSource;
@protocol GTPagingViewDelegate;

@interface GTPagingView : UIView

@property (nonatomic, assign) id<GTPagingViewDataSource> dataSource;
@property (nonatomic, assign) id<GTPagingViewDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

// GTPagingViewDataSource

@protocol GTPagingViewDataSource <NSObject>

- (NSUInteger)numberOfPagesInPagingView:(GTPagingView *)pagingView;
- (UIView *)viewForPageAtIndex:(NSUInteger)index inPagingView:(GTPagingView *)pagingView;

@end


// GTPagingViewDelegate

@protocol GTPagingViewDelegate <NSObject>

@optional
- (void)pagingView:(GTPagingView *)pagingView didMoveToPageAtIndex:(NSUInteger)index;

@end
