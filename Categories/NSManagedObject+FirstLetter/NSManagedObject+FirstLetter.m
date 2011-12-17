//
//  NSManagedObject+FirstLetter.m
//  JapaneseGrammarDictionary
//
//  Created by Gianluca Tranchedone on 09/05/11.
//  Copyright 2011 Sketch to Code. All rights reserved.
//

#import "NSManagedObject+FirstLetter.h"

@implementation NSManagedObject (FirstLetter)

- (NSString *)uppercaseFirstLetterOfTitle 
{
    [self willAccessValueForKey:@"uppercaseFirstLetterOfTitle"];
    NSString *aString = [[self valueForKey:@"title"] uppercaseString];
    
    // support UTF-16:
    NSString *stringToReturn = [aString substringWithRange:[aString rangeOfComposedCharacterSequenceAtIndex:0]];
    
    // OR no UTF-16 support:
    //NSString *stringToReturn = [aString substringToIndex:1];
    
    [self didAccessValueForKey:@"uppercaseFirstLetterOfTitle"];
    return stringToReturn;
}

@end


