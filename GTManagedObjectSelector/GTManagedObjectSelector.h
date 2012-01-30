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

@property (nonatomic, assign) id<GTManagedObjectSelectorDelegate> delegate;

@property (nonatomic, assign) BOOL showSearchBar; // Default is YES.
@property (nonatomic, assign) BOOL allowNewObjectsCreation; // Default is YES.
@property (nonatomic, readonly) NSManagedObject *selectedManagedObject; // subclasses must provide this!

// Properties to set to use this class.
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end


// GTManagedObjectSelectorDelegate

@protocol GTManagedObjectSelectorDelegate <NSObject>

- (void)didFinishWithManagedObject:(NSManagedObject *)managedObject;

@end
