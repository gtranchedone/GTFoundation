//
//  GTAxesView.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 The @class GTAxesView is a view displaying a Carthesian Axis Sistem with @class GTAxisPoints on both axes that can be set using the
 @protocol GTAxesViewDataSource @method 'pointsForAxisInAxesView:'.
 It also provides a scrolling area with the @property 'scrollView'. The scrolling area attributes are to be set by the user.
 */

@protocol GTAxesViewDataSource;

@interface GTAxesView : UIView

@property (nonatomic, readonly) CGPoint origin;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
