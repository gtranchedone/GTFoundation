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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDecimalFormatter = [[NSNumberFormatter alloc] init];
        [sharedDecimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [sharedDecimalFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [sharedDecimalFormatter setMinimumFractionDigits:2];
        [sharedDecimalFormatter setMaximumFractionDigits:2];
    });
    
    return sharedDecimalFormatter;
}

+ (NSNumberFormatter *)currencyFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCurrencyFormatter = [[NSNumberFormatter alloc] init];
        [sharedCurrencyFormatter setLocale:[NSLocale currentLocale]];
        [sharedCurrencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    });
    
    return sharedCurrencyFormatter;
}

+ (NSNumberFormatter *)currencyFormatterForCurrency:(NSString *)currencyCode
{
    NSNumberFormatter *numberFormatter = [self currencyFormatter];
    if (![[numberFormatter currencyCode] isEqualToString:currencyCode]) {
        [numberFormatter setCurrencyCode:currencyCode];
    }
    
    return numberFormatter;
}

@end
