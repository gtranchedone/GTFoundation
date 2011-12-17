//
//  NSDateFormatter+SharedFormatter.m
//  MoneyFlow
//
//  Created by Gianluca Tranchedone on 22/11/11.
//  Copyright (c) 2011 Sketch to Code. All rights reserved.
//

#import "NSDateFormatter+SharedFormatter.h"

static NSDateFormatter *sharedInstance = nil;

@implementation NSDateFormatter (SharedFormatter)

+ (NSDateFormatter *)sharedFormatter
{
    if (!sharedInstance)
    {
        sharedInstance =  [[NSDateFormatter alloc] init];
        [sharedInstance setDateStyle:NSDateFormatterMediumStyle];
        [sharedInstance setLocale:[NSLocale currentLocale]];
        [sharedInstance setDoesRelativeDateFormatting:YES];
    }
    
    return sharedInstance;
}

@end
