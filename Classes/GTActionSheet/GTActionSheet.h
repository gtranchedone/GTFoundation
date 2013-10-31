//
//  GTActionSheet.h
//  GTFoundation
//
//  Created by Gianluca Tranchedone on 17/04/12.
//  Copyright (c) 2013 Cocoa Beans GT Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTActionSheet : UIActionSheet {
    @protected
    NSMutableArray *_blocksArray;
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle;
- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)buttonTitle destructiveBlock:(void(^)(void))destructiveBlock;

- (id)initWithTitle:(NSString *)title 
        cancelButtonTitle:(NSString *)cancelButtonTitle 
        cancelButtonSelectionBlock:(void(^)(void))cancelButtonBlock 
        destructiveButtonTitle:(NSString *)destructiveButtonTitle 
        destructiveButtonSelectionBlock:(void(^)(void))destructiveButtonSelectionBlock;

- (NSInteger)addButtonWithTitle:(NSString *)title selectionBlock:(void(^)(void))block;

@end
