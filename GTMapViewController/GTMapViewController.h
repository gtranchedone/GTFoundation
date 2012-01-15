//
//  GTMapViewController.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 05/12/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol GTMapViewControllerDelegate;

@interface GTMapViewController : UIViewController

@property (nonatomic, assign) id<GTMapViewControllerDelegate> delegate;

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, readonly, strong) CLLocation *currentLocation;
@property (nonatomic, readonly, strong) CLLocation *shownLocation;

@property (nonatomic, strong) UILabel *searchDescriptionLabel;
@property (nonatomic, strong) UITextField *searchField;

- (void)showCurrentLocation;
- (void)showLocation:(CLLocation *)location;
- (void)dropPinAtLocation:(CLLocation *)location;
- (CLLocation *)searchLocationWithName:(NSString *)locationName;

- (UIImage *)takePictureOfRectInMapView:(CGRect)rect;

@end

// GTMapViewControllerDelegate

@protocol GTMapViewControllerDelegate <NSObject>

@optional
- (void)mapViewControllerDidStartUpdating:(GTMapViewController *)controller;
- (void)mapViewControllerDidFinishUpdating:(GTMapViewController *)controller success:(BOOL)success;
- (void)mapViewController:(GTMapViewController *)controller didFinishWithLocation:(CLLocation *)location;

@end
