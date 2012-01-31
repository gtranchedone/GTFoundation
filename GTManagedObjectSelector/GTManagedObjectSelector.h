//
//  GTManagedObjectSelector.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 27/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol GTManagedObjectSelectorDelegate;

@interface GTManagedObjectSelector : UITableViewController <UISearchBarDelegate, NSFetchedResultsControllerDelegate>
{
    @protected
    NSFetchedResultsController *_fetchedResultsController;
}

@property (nonatomic, assign) id<GTManagedObjectSelectorDelegate> delegate;

@property (nonatomic, assign) BOOL allowNewObjectsCreation; // Default is YES.
@property (nonatomic, strong, readonly) NSManagedObject *selectedManagedObject;

@property (nonatomic, strong, readonly) UISearchBar *searchBar;
@property (nonatomic, strong, readonly) NSArray *searchResults; // nil when not searching.
@property (nonatomic, readonly, getter = isSearching) BOOL seaching;
@property (nonatomic, readonly) NSPredicate *searchPredicate;

// Properties to set to use this class.
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (NSManagedObject *)creteNewEntity; // default implementation returns nil. To be overridden by subclasses.

@end


// GTManagedObjectSelectorDelegate

@protocol GTManagedObjectSelectorDelegate <NSObject>

- (void)managedObjectSelector:(GTManagedObjectSelector *)managedObjectSelector didFinishWithManagedObject:(NSManagedObject *)object;

@end
