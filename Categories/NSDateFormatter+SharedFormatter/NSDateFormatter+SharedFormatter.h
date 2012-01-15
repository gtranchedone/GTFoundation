//
//  NSDateFormatter+SharedFormatter.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 22/11/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (SharedFormatter)

+ (NSDateFormatter *)sharedFormatter;

@end
