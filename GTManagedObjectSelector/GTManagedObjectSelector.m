//
//  GTManagedObjectSelector.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 27/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTManagedObjectSelector.h"

@interface GTManagedObjectSelector ()

@property (nonatomic, strong, readwrite) NSArray *searchResults;
@property (nonatomic, readwrite, getter = isSearching) BOOL seaching;

- (void)doneButtonPressed;

@end

#pragma mark - Implementation

@implementation GTManagedObjectSelector

@synthesize delegate = _delegate;

@synthesize searchBar = _searchBar;
@synthesize searchResults = _searchResults;
@synthesize selectedManagedObject = _selectedManagedObject;
@synthesize allowNewObjectsCreation = _allowNewObjectsCreation;

@synthesize fetchedResultsController = _fetchedResultsController;

@synthesize seaching = _seaching;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Done Button
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                target:self action:@selector(doneButtonPressed)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    // Options
    self.allowNewObjectsCreation = YES;
    
    // Search Bar
    self.tableView.tableHeaderView = self.searchBar;
    
    // Perform Fetch
    [self.fetchedResultsController performFetch:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (void)doneButtonPressed
{
    if (self.selectedManagedObject) {
        if ([self.delegate respondsToSelector:@selector(managedObjectSelector:didFinishWithManagedObject:)]) {
            [self.delegate managedObjectSelector:self didFinishWithManagedObject:self.selectedManagedObject];
        }
    }
    else {
        GTAlertView *alertView = [[GTAlertView alloc] initWithTitle:NSLocalizedString(@"No choice was made!", nil) message:nil cancelButtonTitle:NSLocalizedString(@"Cancel", nil) cancelBlock:void_completion_block];
        [alertView show];
    }
}

- (NSManagedObject *)creteNewEntity
{
    // to override in subclasses.
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ((self.allowNewObjectsCreation && self.seaching) || self.selectedManagedObject) {
        return 2;
    }
    else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ((self.allowNewObjectsCreation && self.selectedManagedObject && self.seaching)  && (section == 0)) {
        return 2;
    }
    else if (((self.allowNewObjectsCreation && self.seaching) || self.selectedManagedObject) && (section == 0)) {
        return 1;
    }
    else {
        if (self.seaching) {
            return self.searchResults.count;
        }
        else {
            return self.fetchedResultsController.fetchedObjects.count;
        }
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
    if (self.seaching && (indexPath.section == 0)) {
        id newEntity = [self creteNewEntity];
        
        if (newEntity) {
            self.selectedManagedObject = newEntity;
            [self searchBar:self.searchBar textDidChange:self.searchBar.text]; // reload search results
        }
        else {
            if ([self isSearching] && [self.searchBar.text isEqualToString:@""]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"You cannot create an object with no name!", nil) 
                                                                message:NSLocalizedString(@"Write a name in the search bar and try again.", nil) 
                                                               delegate:nil 
                                                      cancelButtonTitle:NSLocalizedString(@"Continue", nil) 
                                                      otherButtonTitles:nil];
                [alert show];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"You cannot create an object with this name", nil) 
                                                                message:NSLocalizedString(@"There's already an object with the same name: choose a diffent one and try again.", nil) 
                                                               delegate:nil 
                                                      cancelButtonTitle:NSLocalizedString(@"Continue", nil) 
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
    else {
        if (self.seaching) {
            self.selectedManagedObject = [self.searchResults objectAtIndex:indexPath.row];
        }
        else {
            NSIndexPath *objectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            self.selectedManagedObject = [self.fetchedResultsController objectAtIndexPath:objectIndexPath];
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{    
    self.searchResults = [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:self.searchPredicate];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
    self.searchResults = nil;
    self.seaching = NO;
    
    [self.tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.seaching = YES;
    [searchBar setShowsCancelButton:YES animated:YES];
    [self.tableView reloadData];
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self searchBarCancelButtonClicked:searchBar];
    return YES;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller 
{
	// The fetch controller is about to start sending change notifications, so prepare the table view for updates.
	[self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath 
{	
	UITableView *tableView = self.tableView;
    
	switch(type) 
    {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
			break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type 
{
	switch(type) 
    {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[self.tableView endUpdates];
}

#pragma mark - Custom Setters and Getters

- (NSFetchedResultsController *)fetchedResultsController
{
    // to be overridden by subclasses
    return _fetchedResultsController;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:(CGRect){0, 0, self.view.bounds.size.width, 50}];
        _searchBar.delegate = self;
    }
    
    return _searchBar;
}

- (NSPredicate *)searchPredicate
{
    return nil;
}

@end
