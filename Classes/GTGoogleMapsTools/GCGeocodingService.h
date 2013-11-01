//
//  GCGeocodingService.h
//  GeocodingAPISample
//
//  Created by Mano Marks on 4/11/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#ifdef __CORELOCATION__

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GCGeocodingService : NSObject

+ (void)geocodeAddress:(NSString *)address withCompletionBlock:(void (^)(CLPlacemark *placemark, NSError *error))completionBlock;

@end

#endif
