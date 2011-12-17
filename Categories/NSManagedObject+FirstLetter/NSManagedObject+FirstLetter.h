//
//  NSManagedObject+FirstLetter.h
//  JapaneseGrammarDictionary
//
//  Created by Gianluca Tranchedone on 09/05/11.
//  Copyright 2011 Sketch to Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObject (FirstLetter)

- (NSString *)uppercaseFirstLetterOfTitle;

@end
