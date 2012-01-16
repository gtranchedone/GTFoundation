//
//  GTGraphObjectProtocol.h
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 16/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GTGraphObjectProtocol <NSObject>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat value;

@end
