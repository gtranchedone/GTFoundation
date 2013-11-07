//
//  GTUtilityFunctions.m
//  GTFoundation
//
//  Created by Gianluca Tranchedone on 14/08/13.
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Gianluca Tranchedone
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "GTUtilityFunctions.h"

void GTShowAlertViewWithTitleAndMessage(NSString *title, NSString *message)
{
#if TARGET_OS_IPHONE
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:message 
                                                   delegate:nil 
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", nil) 
                                          otherButtonTitles:nil];
    [alert show];
#else
#endif
}

CGFloat GTRadiansFromDegrees(CGFloat degrees)
{
    return (degrees * M_PI) / 180;
}

NSString *GTCurrencySymbolFromCurrencyCode(NSString *currencyCode)
{
    if (!currencyCode) {
        return nil;
    }
    else {
        NSDictionary *localeComponents = [NSDictionary dictionaryWithObject:currencyCode forKey:NSLocaleCurrencyCode];
        NSString *localeIdentifier = [NSLocale localeIdentifierFromComponents:localeComponents];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
        NSString *currencySymbol = [locale objectForKey:NSLocaleCurrencySymbol];
        
        NSCharacterSet *symbols = [NSCharacterSet symbolCharacterSet];
        if ([currencySymbol rangeOfCharacterFromSet:symbols].location != NSNotFound) {
            currencySymbol = [currencySymbol substringFromIndex:currencySymbol.length - 1];
        }
        
        return currencySymbol;
    }
}