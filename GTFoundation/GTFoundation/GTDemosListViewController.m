//
//  GTDemosListViewController.m
//  GTFoundation
//
//  Created by Gianluca Tranchedone on 01/11/2013.
//  Copyright (c) 2013 Cocoa Beans GT Limited. All rights reserved.
//

#import "GTDemosListViewController.h"

@interface GTDemosMenuItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *destinationViewControllerName;

+ (instancetype)itemWithTitle:(NSString *)title destinationViewControllerName:(NSString *)name;

@end

@implementation GTDemosMenuItem

+ (instancetype)itemWithTitle:(NSString *)title destinationViewControllerName:(NSString *)name
{
    GTDemosMenuItem *item = [[self alloc] init];
    item.destinationViewControllerName = name;
    item.title = title;
    
    return item;
}

@end


@interface GTDemosListViewController ()

@property (nonatomic, copy) NSArray *demos;

@end

@implementation GTDemosListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.demos = @[[GTDemosMenuItem itemWithTitle:@"Google Maps Geocoding" destinationViewControllerName:@"GTGoogleMapsGeocodingViewController"]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    GTDemosMenuItem *item = [self.demos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GTDemosMenuItem *item = [self.demos objectAtIndex:indexPath.row];
    Class viewControllerClass = NSClassFromString(item.destinationViewControllerName);
    id viewController = [[viewControllerClass alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
