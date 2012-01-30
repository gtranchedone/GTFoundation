//
//  GTGraphObject.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 17/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTGraphObject : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat value; // 0.0 .. 1.0, default is 0.0. values outside are pinned.

@end
