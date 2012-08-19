//
//  GTUtilityFunctions.h
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 26/06/12.
//  Copyright (c) 2012 Gianluca Tranchedone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TODO_WITH_TITLE(title) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title \
message:nil delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil]; \
[alert show];

#define TODO TODO_WITH_TITLE(@"TODO")

extern void ShowAlertViewWithTitleAndMessage(NSString *title, NSString *message);

extern CGFloat RadiansFromDegrees(CGFloat degrees);
extern NSString *CurrencySymbolFromCurrencyCode(NSString *currencyCode);
extern NSString *NSStringFromNSCalendarUnit(NSCalendarUnit calendarUnit);
extern NSString *ImagePathForSavingImageInDirectory(UIImage *image, NSString *imageDirectoryPath);
