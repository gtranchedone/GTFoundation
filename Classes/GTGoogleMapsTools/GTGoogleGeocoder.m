//
//  GCGeocodingService.m
//  GeocodingAPISample
//
//  Created by Mano Marks on 4/11/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#ifdef __CORELOCATION__

#import "GTGoogleGeocoder.h"

@implementation GTGoogleGeocoder

+ (void)geocodeAddress:(NSString *)address withCompletionBlock:(void (^)(CLLocation *, NSError *))completionBlock
{
    NSString *geocodingBaseUrl = @"http://maps.googleapis.com/maps/api/geocode/json?";
    NSString *url = [NSString stringWithFormat:@"%@address=%@&sensor=false", geocodingBaseUrl,address];
    url = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSURL *queryUrl = [NSURL URLWithString:url];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        CLLocation *location = nil;
        
        NSError *networkError = nil;
        NSData *responseData = [NSData dataWithContentsOfURL:queryUrl options:NSDataReadingMappedIfSafe error:&networkError];
        
        if (responseData && !networkError) {
            NSError *jsonError = nil;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
            
            if (jsonDictionary && !jsonError) {
                location = [self placemarkFromResponseDictionary:jsonDictionary];
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
                completionBlock(location, error);
            }
        });
    });
}

+ (CLLocation *)placemarkFromResponseDictionary:(NSDictionary *)dictionary {
    NSArray *results = [dictionary objectForKey:@"results"];
    NSDictionary *result = [results objectAtIndex:0];
    
    NSDictionary *geometry = [result objectForKey:@"geometry"];
    NSDictionary *location = [geometry objectForKey:@"location"];
    NSString *lat = [location objectForKey:@"lat"];
    NSString *lng = [location objectForKey:@"lng"];
    
    return [[CLLocation alloc] initWithLatitude:lat.doubleValue longitude:lng.doubleValue];
}

@end

#endif

