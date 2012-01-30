//
//  GTManagedObjectSelector.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 27/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTManagedObjectSelector.h"

@interface GTManagedObjectSelector ()

- (void)doneButtonPressed;

@end

#pragma mark - Implementation

@implementation GTManagedObjectSelector

@synthesize delegate = _delegate;

@synthesize showSearchBar = _showSearchBar;
@synthesize allowNewObjectsCreation = _allowNewObjectsCreation;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Done Button
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                target:self action:@selector(doneButtonPressed)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    // Options
    self.showSearchBar = YES;
    self.allowNewObjectsCreation = YES;
    
    // Perform Fetch
    [self.fetchedResultsController performFetch:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (NSManagedObject *)selectedManagedObject
{
    // to be implemented in a subclass
    return nil;
}

#pragma mark - Actions

- (void)doneButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(didFinishWithManagedObject:)]) {
        [self.delegate didFinishWithManagedObject:self.selectedManagedObject];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.allowNewObjectsCreation) {
        return self.fetchedResultsController.fetchedObjects.count + 1; // add a row for object creation
    } 
    else {
        return self.fetchedResultsController.fetchedObjects.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Custom Setters and Getters

- (void)setShowSearchBar:(BOOL)showSearchBar
{
    _showSearchBar = showSearchBar;
    
    // TODO
}

@end
