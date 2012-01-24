//
//  GTGraphObject.m
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 17/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTGraphObject.h"

@implementation GTGraphObject

@synthesize title = _title;
@synthesize value = _value;

- (void)setValue:(CGFloat)value
{
    if (value < 0) {
        _value = 0;
    }
    else if (value > 1) {
        _value = 1;
    }
    else {
        _value = value;
    }
}

@end
