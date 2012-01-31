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

@interface GTManagedObjectSelector : UITableViewController <NSFetchedResultsControllerDelegate>
{
    @protected
    NSFetchedResultsController *_fetchedResultsController;
}

@property (nonatomic, assign) id<GTManagedObjectSelectorDelegate> delegate;

@property (nonatomic, assign) BOOL showSearchBar; // Default is YES.
@property (nonatomic, assign) BOOL allowNewObjectsCreation; // Default is YES.
@property (nonatomic, strong, readonly) NSArray *searchResults; // nil when not searching.
@property (nonatomic, strong, readonly) NSManagedObject *selectedManagedObject;

// Properties to set to use this class.
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (NSManagedObject *)creteNewEntity; // default implementation returns nil. To be overridden by subclasses.

@end


// GTManagedObjectSelectorDelegate

@protocol GTManagedObjectSelectorDelegate <NSObject>

- (void)managedObjectSelector:(GTManagedObjectSelector *)managedObjectSelector didFinishWithManagedObject:(NSManagedObject *)object;

@end
