//
//  NSNumberFormatter+SharedFormatter.m
//  MyFinances
//
//  Created by Gianluca Tranchedone on 19/09/11.
//  Copyright (c) 2011 SketchToCode. All rights reserved.
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
        [sharedDecimalFormatter setGroupingSeparator:@""];
        [sharedDecimalFormatter setDecimalSeparator:@"."];
        [sharedDecimalFormatter setZeroSymbol:@"0.00"];
    }
    
    return sharedDecimalFormatter;
}

+ (NSNumberFormatter *)currencyFormatter
{
    if (!sharedCurrencyFormatter) 
    {
        sharedCurrencyFormatter = [[NSNumberFormatter alloc] init];
        [sharedCurrencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [sharedCurrencyFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [sharedCurrencyFormatter setMaximumFractionDigits:2];
        [sharedCurrencyFormatter setMinimumFractionDigits:2];
        [sharedCurrencyFormatter setNegativeFormat:@"#,##0¤"];
        [sharedCurrencyFormatter setPositiveFormat:@"#,##0¤"];
        [sharedCurrencyFormatter setCurrencyGroupingSeparator:@"."];
        [sharedCurrencyFormatter setCurrencyDecimalSeparator:@","];
    }
    
    return sharedCurrencyFormatter;
}

@end
