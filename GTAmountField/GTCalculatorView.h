//
//  GTCalculatorView.h
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 10/05/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTCalculatorView : UIView

@property (nonatomic, readonly, assign) NSDecimalNumber *currentValue;

- (id)initWithFrame:(CGRect)frame initialValue:(NSDecimalNumber *)initialValue;

@end
