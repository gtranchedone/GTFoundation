//
//  GTMapViewController.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 05/12/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTMapViewController.h"

NSString * const MapsAddressSearchURL = @"http://maps.google.com/maps/geo?q=%@&output=csv&key=%@";
NSString * const GoogleMapsAPIKey = @"ABQIAAAAQzOGnmoWEb53mcdg1ffYQxQDS2F2zJ4o2IrRcvdRtMaoKJ1mfhS_wJEB5hJiElfEBcZ4CEB-E4nnZQ";

#define TextMargin 10
#define LabelsHeight 25

@interface GTMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate>

@property (nonatomic, readwrite, strong) CLLocation *currentLocation;
@property (nonatomic, readwrite, strong) CLLocation *shownLocation;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)informDelegate;

@end

#pragma mark - Implementation

@implementation GTMapViewController

@synthesize delegate = _delegate;
@synthesize mapView = _mapView;
@synthesize currentLocation = _currentLocation;
@synthesize shownLocation = _shownLocation;

@synthesize locationManager = _locationManager;
@synthesize activityIndicator = _activityIndicator;

@synthesize searchDescriptionLabel = _searchDescriptionLabel;
@synthesize searchField = _searchField;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"GTMapViewController";
    self.view.backgroundColor = [UIColor dimGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                           target:self 
                                                                                           action:@selector(informDelegate)];
    // Setup the search field
    [self.view addSubview:self.searchDescriptionLabel];
    [self.view addSubview:self.searchField];
    
    // Setup the Map
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

- (void)informDelegate
{
    if ([self.delegate respondsToSelector:@selector(mapViewController:didFinishWithLocation:)]) {
        [self.delegate mapViewController:self didFinishWithLocation:self.currentLocation];
    }
}

- (void)showCurrentLocation
{
    // Add the spinner
    [self.mapView addSubview:self.activityIndicator];
    
    // update the current location (this is automatically shown on the map)
    [self.locationManager startUpdatingLocation];
    
    if ([self.delegate respondsToSelector:@selector(mapViewControllerDidStartUpdating:)]) {
        [self.delegate mapViewControllerDidStartUpdating:self];
    }
}

// TODO: not working?
- (void)showLocation:(CLLocation *)location
{
    self.shownLocation = location;
    [self.mapView setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01, 0.01))];
}

- (void)dropPinAtLocation:(CLLocation *)location
{
    // TODO
}

- (CLLocation *)searchLocationWithName:(NSString *)locationName
{
    CLLocation *location = nil;
    
    locationName = [locationName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *urlString = [NSString stringWithFormat:MapsAddressSearchURL, locationName, GoogleMapsAPIKey];
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] 
                                                        encoding:NSStringEncodingConversionAllowLossy error:nil];
    NSArray *listItems = [locationString componentsSeparatedByString:@","];
    
    double latitude = 0.0;
    double longitude = 0.0;
    
    if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
        latitude = [[listItems objectAtIndex:2] doubleValue];
        longitude = [[listItems objectAtIndex:3] doubleValue];
    }
    else {
        NSLog(@"Error while searching address");
    }
    
    location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    return location;
}

- (UIImage *)takePictureOfRectInMapView:(CGRect)rect
{
    return [UIImage captureRect:rect inView:self.mapView];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.activityIndicator removeFromSuperview];
    
    [manager stopUpdatingLocation];
    [self showLocation:newLocation];
    self.currentLocation = newLocation;
    
    if ([self.delegate respondsToSelector:@selector(mapViewControllerDidFinishUpdating:success:)]) {
        [self.delegate mapViewControllerDidFinishUpdating:self success:YES];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.activityIndicator removeFromSuperview];
    
    NSLog(@"%@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"An error occurred while loading location", nil) 
                                                    message:[NSString stringWithFormat:@"%@", error] 
                                                   delegate:self 
                                          cancelButtonTitle:NSLocalizedString(@"Continue", nil) 
                                          otherButtonTitles:nil];
    [alert show];
    
    if ([self.delegate respondsToSelector:@selector(mapViewControllerDidFinishUpdating:success:)]) {
        [self.delegate mapViewControllerDidFinishUpdating:self success:NO];
    }
}

#pragma mark - MKMapViewDelegate

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    if (textField.text) {
        CLLocation *location = [self searchLocationWithName:textField.text];
        [self showLocation:location];
    }
    
    return YES;
}

#pragma mark - Custom Setters and Getters

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.purpose = @"Get Device Location";
        _locationManager.delegate = self;
    }
    
    return _locationManager;
}

- (MKMapView *)mapView 
{
    if (!_mapView) {
        CGFloat originY = self.view.bounds.size.height / 4;
        CGRect frame = CGRectMake(0.0, originY, self.view.bounds.size.width, self.view.bounds.size.height - originY);
        _mapView = [[MKMapView alloc] initWithFrame:frame];
        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
    }
    
    return _mapView;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicator.center = self.mapView.center;
        [_activityIndicator startAnimating];
    }
    
    return _activityIndicator;
}

- (UILabel *)searchDescriptionLabel
{
    if (!_searchDescriptionLabel) {
        CGRect frame = (CGRect){TextMargin, TextMargin, self.view.bounds.size.width - (TextMargin * 2), LabelsHeight};
        
        _searchDescriptionLabel = [[UILabel alloc] initWithFrame:frame];
        _searchDescriptionLabel.font = [UIFont boldSystemFontOfSize:18];
        _searchDescriptionLabel.backgroundColor = [UIColor clearColor];
        _searchDescriptionLabel.textColor = [UIColor whiteColor];
        
        _searchDescriptionLabel.text = NSLocalizedString(@"Type and address to search", nil);
    }
    return _searchDescriptionLabel;
}

- (UITextField *)searchField
{
    if (!_searchField) {
        CGRect frame = CGRectMake(TextMargin, self.searchDescriptionLabel.bounds.size.height + (TextMargin * 2), 
                                  self.view.bounds.size.width - (TextMargin * 2), 
                                  self.view.bounds.size.height - self.mapView.bounds.size.height - self.searchDescriptionLabel.bounds.size.height - (TextMargin * 3));
        
        _searchField = [[UITextField alloc] initWithFrame:frame];
        _searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _searchField.clearButtonMode = UITextFieldViewModeAlways;
        _searchField.borderStyle = UITextBorderStyleRoundedRect;
        _searchField.rightViewMode = UITextFieldViewModeAlways;
        _searchField.backgroundColor = [UIColor whiteColor];
        _searchField.delegate = self;
        
        _searchField.placeholder = NSLocalizedString(@"Search an address", nil);
    }
    
    return _searchField;
}

@end
