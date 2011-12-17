//
//  GTMapViewController.h
//  MoneyFlow
//
//  Created by Gianluca Tranchedone on 05/12/11.
//  Copyright (c) 2011 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol GTMapViewControllerDelegate;

@interface GTMapViewController : UIViewController {
    
}

@property (nonatomic, unsafe_unretained) id<GTMapViewControllerDelegate> delegate;

@property (nonatomic, strong) MKMapView *mapView;

- (void)showCurrentLocation;
- (void)showLocationAtLongitude:(double)longitude latitude:(double)latitude;

@end

//_____________________________________________

@protocol GTMapViewControllerDelegate <NSObject>

@optional
- (void)mapViewControllerDidStartUpdating:(GTMapViewController *)controller;
- (void)mapViewControllerDidFinishUpdating:(GTMapViewController *)controller success:(BOOL)success;
- (void)mapViewController:(GTMapViewController *)controller didFinishWithLocation:(CLLocation *)location;

@end
