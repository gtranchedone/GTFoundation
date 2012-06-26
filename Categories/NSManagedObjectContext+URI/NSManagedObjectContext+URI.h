//
//  NSManagedObjectContext+URI.h
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 15/03/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (URI)

- (NSManagedObject *)objectWithURI:(NSURL *)uri;

@end
