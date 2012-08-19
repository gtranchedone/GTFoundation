//
//  GTUtilityFunctions.m
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 26/06/12.
//  Copyright (c) 2012 Gianluca Tranchedone. All rights reserved.
//

#import "GTUtilityFunctions.h"

void ShowAlertViewWithTitleAndMessage(NSString *title, NSString *message)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:message 
                                                   delegate:nil 
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", nil) 
                                          otherButtonTitles:nil];
    [alert show];
}

CGFloat RadiansFromDegrees(CGFloat degrees)
{
    return (degrees * M_PI) / 180;
}

NSString *CurrencySymbolFromCurrencyCode(NSString *currencyCode)
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

NSString *NSStringFromNSCalendarUnit(NSCalendarUnit calendarUnit)
{
    NSString *resultString = nil;
    
    if (calendarUnit) {
        switch (calendarUnit) {
            case NSDayCalendarUnit:
                resultString = NSLocalizedString(@"Repeat Every Day", nil);
                break;
                
            case NSWeekCalendarUnit:
                resultString = NSLocalizedString(@"Repeat Every Week", nil);
                break;
                
            case NSMonthCalendarUnit:
                resultString = NSLocalizedString(@"Repeat Every Month", nil);
                break;
                
            case NSYearCalendarUnit:
                resultString = NSLocalizedString(@"Repeat Every Year", nil);
                break;
                
            default:
                NSLog(@"Calendar Unit Not Valid: %d", calendarUnit);
                break;
        }
    }
    else {
        resultString = NSLocalizedString(@"Never Repeat", nil);
    }
    
    return resultString;
}

NSString *ImagePathForSavingImageInDirectory(UIImage *image, NSString *imageDirectoryPath)
{
    BOOL directoryExists = YES;
    BOOL pathExists = [[NSFileManager defaultManager] fileExistsAtPath:imageDirectoryPath isDirectory:&directoryExists];
    
    if (pathExists && directoryExists) {
        NSString *jpgImageName = [NSString stringWithFormat:@"%@.jpg", [NSDate date]];
        NSString *jpgImagePath = [imageDirectoryPath stringByAppendingPathComponent:jpgImageName];
        NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
        
        NSError *error = nil;
        [data writeToFile:jpgImagePath options:NSDataWritingAtomic error:&error];
        if (error) {
            NSLog(@"Error while writing image to file: %@", error);
        }
        
        return jpgImageName;
    }
    else {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:imageDirectoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (!error) {
            return ImagePathForSavingImageInDirectory(image, imageDirectoryPath);
        }
        else {
            NSLog(@"Couldn't create directory at path %@. Error: %@.", imageDirectoryPath, error);
            return nil;
        }
    }
}
