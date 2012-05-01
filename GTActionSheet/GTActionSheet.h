//
//  GTActionSheet.h
//  iTunesLookupAPITest
//
//  Created by Gianluca Tranchedone on 17/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTActionSheet : UIActionSheet {
    @protected
    NSMutableArray *_blocksArray;
}

- (id)initWithTitle:(NSString *)title 
        cancelButtonTitle:(NSString *)cancelButtonTitle 
        cancelButtonSelectionBlock:(void(^)(void))cancelButtonBlock 
        destructiveButtonTitle:(NSString *)destructiveButtonTitle 
        destructiveButtonSelectionBlock:(void(^)(void))destructiveButtonSelectionBlock;

- (NSInteger)addButtonWithTitle:(NSString *)title selectionBlock:(void(^)(void))block;

@end
