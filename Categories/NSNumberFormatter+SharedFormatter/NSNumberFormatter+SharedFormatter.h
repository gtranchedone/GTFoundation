//
//  NSNumberFormatter+SharedFormatter.h
//  MyFinances
//
//  Created by Gianluca Tranchedone on 19/09/11.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (SharedFormatter)

+ (NSNumberFormatter *)decimalFormatter;
+ (NSNumberFormatter *)currencyFormatter;
+ (NSNumberFormatter *)currencyFormatterForCurrency:(NSString *)currencyCode;

@end
