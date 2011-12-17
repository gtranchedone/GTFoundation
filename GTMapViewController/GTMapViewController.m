//
//  GTMapViewController.m
//  MoneyFlow
//
//  Created by Gianluca Tranchedone on 05/12/11.
//  Copyright (c) 2011 Sketch to Code. All rights reserved.
//

#import "GTMapViewController.h"

@interface GTMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

#pragma mark - Implementation

@implementation GTMapViewController

@synthesize delegate = delegate_;

@synthesize mapView = mapView_;

@synthesize locationManager = locationManager_;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // TODO: change me
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCurrentLocation)];
    
    // Setup the Map
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    [self showCurrentLocation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - Actions

- (void)showCurrentLocation
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.delegate = self;
    }
    
    [self.locationManager startUpdatingLocation];
    
    if ([self.delegate respondsToSelector:@selector(mapViewControllerDidStartUpdating:)]) {
        [self.delegate mapViewControllerDidStartUpdating:self];
    }
}

- (void)showLocationAtLongitude:(double)longitude latitude:(double)latitude
{
    // TODO
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    [self.mapView setRegion:MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01))];
    
    if ([self.delegate respondsToSelector:@selector(mapViewControllerDidFinishUpdating:success:)]) {
        [self.delegate mapViewControllerDidFinishUpdating:self success:YES];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
    if ([self.delegate respondsToSelector:@selector(mapViewControllerDidFinishUpdating:success:)]) {
        [self.delegate mapViewControllerDidFinishUpdating:self success:NO];
    }
}

#pragma mark - MKMapViewDelegate

@end
