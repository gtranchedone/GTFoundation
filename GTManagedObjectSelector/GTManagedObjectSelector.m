//
//  GTManagedObjectSelector.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 27/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTManagedObjectSelector.h"

@interface GTManagedObjectSelector () <UISearchDisplayDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, readwrite) NSArray *searchResults;
@property (nonatomic, strong, readwrite) NSManagedObject *selectedManagedObject;

- (void)doneButtonPressed;

@end

#pragma mark - Implementation

@implementation GTManagedObjectSelector

@synthesize delegate = _delegate;

@synthesize showSearchBar = _showSearchBar;
@synthesize searchResults = _searchResults;
@synthesize allowNewObjectsCreation = _allowNewObjectsCreation;
@synthesize selectedManagedObject = _selectedManagedObject;

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
    self.fetchedResultsController.delegate = self;
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
    if ([self.delegate respondsToSelector:@selector(managedObjectSelector:didFinishWithManagedObject:)]) {
        [self.delegate managedObjectSelector:self didFinishWithManagedObject:self.selectedManagedObject];
    }
}

- (NSManagedObject *)creteNewEntity
{
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.allowNewObjectsCreation) {
        return 2;
    }
    else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.allowNewObjectsCreation && (section == 0)) { // add a row for object creation
        return 1;
    }
    else {
        if (self.searchResults) {
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
    if (self.allowNewObjectsCreation && (indexPath.section == 0)) {
        self.selectedManagedObject = [self creteNewEntity];
    }
    else {
        if (self.searchResults) {
            self.selectedManagedObject = [self.searchResults objectAtIndex:indexPath.row];
        }
        else {
            NSIndexPath *objectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            self.selectedManagedObject = [self.fetchedResultsController objectAtIndexPath:objectIndexPath];
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY contains[cd] %@", searchString];
    self.searchResults = [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:predicate];
    
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    self.searchResults = nil;
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

- (void)setShowSearchBar:(BOOL)showSearchBar
{
    _showSearchBar = showSearchBar;
    
    if (showSearchBar) {
        self.tableView.tableHeaderView = self.searchDisplayController.searchBar;
        self.searchDisplayController.searchResultsDataSource = self;
        self.searchDisplayController.delegate = self;
    }
    else {
        self.tableView.tableHeaderView = nil;
    }
}

- (NSFetchedResultsController *)fetchedResultsController
{
    // to be overridden by subclasses
    return _fetchedResultsController;
}

@end
