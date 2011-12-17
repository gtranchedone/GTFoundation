//
//  NSDateFormatter+SharedFormatter.h
//  MoneyFlow
//
//  Created by Gianluca Tranchedone on 22/11/11.
//  Copyright (c) 2011 Sketch to Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (SharedFormatter)

+ (NSDateFormatter *)sharedFormatter;

@end
