//
//  NSDecimalNumber+Opposite.m
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 29/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "NSDecimalNumber+Opposite.h"

@implementation NSDecimalNumber (Opposite)

- (NSDecimalNumber *)oppositeValue
{
    return [self decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
}

@end
