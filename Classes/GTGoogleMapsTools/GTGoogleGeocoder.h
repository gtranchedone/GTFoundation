//
//  GCGeocodingService.h
//  GeocodingAPISample
//
//  Created by Mano Marks on 4/11/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

//#ifdef __CORELOCATION__

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GTGoogleGeocoder : NSObject

+ (void)geocodeAddress:(NSString *)address withCompletionBlock:(void (^)(CLLocation *location, NSError *error))completionBlock;
+ (void)reverseGeocodeLocationWithCoordinate:(CLLocationCoordinate2D)coordinate completionBlock:(void (^)(CLPlacemark *placemark, NSError *error))completionBlock;
+ (void)autocompleteAddress:(NSString *)address mapsApiKey:(NSString *)apiKey completionBlock:(void (^)(NSArray *results, NSError *completionBlock))completionBlock;

@end

//#endif
