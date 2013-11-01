//
//  GCGeocodingService.m
//  GeocodingAPISample
//
//  Created by Mano Marks on 4/11/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#ifdef __CORELOCATION__

#import "GCGeocodingService.h"

@implementation GCGeocodingService

+ (void)geocodeAddress:(NSString *)address withCompletionBlock:(void (^)(CLPlacemark *, NSError *))completionBlock
{
    NSString *geocodingBaseUrl = @"http://maps.googleapis.com/maps/api/geocode/json?";
    NSString *url = [NSString stringWithFormat:@"%@address=%@&sensor=false", geocodingBaseUrl,address];
    url = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSURL *queryUrl = [NSURL URLWithString:url];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        CLPlacemark *placemark = nil;
        
        NSError *networkError = nil;
        NSData *responseData = [NSData dataWithContentsOfURL:queryUrl options:NSDataReadingMappedIfSafe error:&networkError];
        
        if (responseData && !networkError) {
            NSError *jsonError = nil;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
            
            if (jsonDictionary && !jsonError) {
                placemark = [self placemarkFromResponseDictionary:jsonDictionary];
            }
            else {
                error = jsonError;
            }
        }
        else {
            error = networkError;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(placemark, error);
            }
        });
    });
}

+ (CLPlacemark *)placemarkFromResponseDictionary:(NSDictionary *)dictionary {
    NSArray *results = [dictionary objectForKey:@"results"];
    NSDictionary *result = [results objectAtIndex:0];
    
    NSDictionary *geometry = [result objectForKey:@"geometry"];
    NSDictionary *location = [geometry objectForKey:@"location"];
    NSString *lat = [location objectForKey:@"lat"];
    NSString *lng = [location objectForKey:@"lng"];
    
    /*
     The Address Dictionary = {
        City = London;
        Country = "United Kingdom";
        CountryCode = GB;
        FormattedAddressLines =     (
            "Marlborough Road",
            London,
            "SE18 6PJ",
            England
        );
        PostCodeExtension = PJ;
        State = England;
        Street = "Marlborough Road";
        SubAdministrativeArea = London;
        SubLocality = "Woolwich Riverside";
        Thoroughfare = "Marlborough Road";
        ZIP = "SE18 6";
     }
     */
    NSString *address = [result objectForKey:@"formatted_address"];
    NSDictionary *addressDictionary = @{};
    
    CLPlacemark *placemark = [[CLPlacemark alloc] init];
    [placemark setValue:addressDictionary forKey:@"addressDictionary"];
    [placemark setValue:[[CLLocation alloc] initWithLatitude:lat.doubleValue longitude:lng.doubleValue] forKey:@"location"];
    
    return placemark;
}

@end

#endif

