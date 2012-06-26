//
//  GTSpinnerButton.h
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 01/05/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTSpinnerButton : UIButton

@property (nonatomic, strong) UIActivityIndicatorView *spinner;

- (void)startSpinner;
- (void)stopSpinner;

@end
