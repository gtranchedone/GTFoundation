//
//  GTMapAnnotation.m
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 26/06/12.
//  Copyright (c) 2012 Gianluca Tranchedone. All rights reserved.
//

#import "GTMapAnnotation.h"

@interface GTMapAnnotation ()

@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, readwrite, copy) NSString *subtitle;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end


@implementation GTMapAnnotation

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle coordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
    }
    return self;
}

@end
