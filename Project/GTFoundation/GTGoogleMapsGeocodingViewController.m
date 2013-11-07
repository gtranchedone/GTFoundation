//
//  GTGoogleMapsGeocodingViewController.m
//  GTFoundation
//
//  Created by Gianluca Tranchedone on 01/11/2013.
//  Copyright (c) 2013 Cocoa Beans GT Limited. All rights reserved.
//

#import "GTGoogleMapsGeocodingViewController.h"
#import "GTGoogleGeocoder.h"

@implementation GTGoogleMapsGeocodingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[GTGoogleGeocoder geocodeAddress:@"Google Campus London" withCompletionBlock:^(CLLocation *location, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

@end
