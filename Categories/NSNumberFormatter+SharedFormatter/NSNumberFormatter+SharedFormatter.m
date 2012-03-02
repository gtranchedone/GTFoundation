//
//  NSNumberFormatter+SharedFormatter.m
//  MyFinances
//
//  Created by Gianluca Tranchedone on 19/09/11.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "NSNumberFormatter+SharedFormatter.h"

static NSNumberFormatter *sharedDecimalFormatter = nil;
static NSNumberFormatter *sharedCurrencyFormatter = nil;

@implementation NSNumberFormatter (SharedFormatter)

+ (NSNumberFormatter *)decimalFormatter
{
    if (!sharedDecimalFormatter) {
        sharedDecimalFormatter = [[NSNumberFormatter alloc] init];
        [sharedDecimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [sharedDecimalFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [sharedDecimalFormatter setMinimumFractionDigits:2];
        [sharedDecimalFormatter setMaximumFractionDigits:2];
    }
    
    return sharedDecimalFormatter;
}

+ (NSNumberFormatter *)currencyFormatter
{
    if (!sharedCurrencyFormatter) 
    {
        sharedCurrencyFormatter = [[NSNumberFormatter alloc] init];
        [sharedCurrencyFormatter setLocale:[NSLocale currentLocale]];
        [sharedCurrencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [sharedCurrencyFormatter setNegativeFormat:@"-#,##0.00¤"];
        [sharedCurrencyFormatter setPositiveFormat:@"#,##0.00¤"];
    }
    
    return sharedCurrencyFormatter;
}

@end
