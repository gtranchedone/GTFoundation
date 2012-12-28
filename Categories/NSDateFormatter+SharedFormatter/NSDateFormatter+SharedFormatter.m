//
//  NSDateFormatter+SharedFormatter.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 22/11/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "NSDateFormatter+SharedFormatter.h"

static NSDateFormatter *sharedInstance = nil;
static NSDateFormatter *formatterWithoutTime = nil;

@implementation NSDateFormatter (SharedFormatter)

+ (NSDateFormatter *)sharedFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance =  [[NSDateFormatter alloc] init];
        [sharedInstance setDateStyle:NSDateFormatterMediumStyle];
        [sharedInstance setTimeStyle:NSDateFormatterShortStyle];
        [sharedInstance setLocale:[NSLocale currentLocale]];
        [sharedInstance setDoesRelativeDateFormatting:YES];
    });
    
    return sharedInstance;
}

+ (NSDateFormatter *)sharedFormatterWithoutTime
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterWithoutTime =  [[NSDateFormatter alloc] init];
        [formatterWithoutTime setDoesRelativeDateFormatting:NO];
        [formatterWithoutTime setLocale:[NSLocale currentLocale]];
        [formatterWithoutTime setTimeStyle:NSDateFormatterNoStyle];
        [formatterWithoutTime setDateStyle:NSDateFormatterFullStyle];
    });
    
    return formatterWithoutTime;
}

@end
