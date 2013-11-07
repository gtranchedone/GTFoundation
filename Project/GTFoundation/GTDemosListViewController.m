//
//  GTDemosListViewController.m
//  GTFoundation
//
//  Created by Gianluca Tranchedone on 14/08/13.
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Gianluca Tranchedone
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "GTDemosListViewController.h"
#import "GTFoundation.h"

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

    self.demos = @[];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    GTAlertView *alertView = [[GTAlertView alloc] initWithTitle:@"TEST" message:@"This is a test" cancelButtonTitle:@"Dismiss"];
    [alertView show];
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
