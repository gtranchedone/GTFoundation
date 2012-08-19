//
//  GTActionSheet.m
//  iTunesLookupAPITest
//
//  Created by Gianluca Tranchedone on 17/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTActionSheet.h"

@interface GTActionSheet () <UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *blocksArray;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, strong) void(^cancelButtonBlock)(void);

- (void)addCancelButton;

@end

#pragma mark - Implementation

@implementation GTActionSheet

@synthesize blocksArray = _blocksArray;
@synthesize cancelButtonTitle = _cancelButtonTitle;
@synthesize cancelButtonBlock = _cancelButtonBlock;

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle
{
    return [self initWithTitle:title cancelButtonTitle:cancelButtonTitle cancelButtonSelectionBlock:^{} destructiveButtonTitle:nil destructiveButtonSelectionBlock:^{}];
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)buttonTitle destructiveBlock:(void(^)(void))destructiveBlock
{
    return [self initWithTitle:title cancelButtonTitle:cancelButtonTitle cancelButtonSelectionBlock:^{} destructiveButtonTitle:buttonTitle destructiveButtonSelectionBlock:destructiveBlock];
}

- (id)initWithTitle:(NSString *)title
        cancelButtonTitle:(NSString *)cancelButtonTitle 
        cancelButtonSelectionBlock:(void (^)(void))cancelButtonBlock
        destructiveButtonTitle:(NSString *)destructiveButtonTitle 
        destructiveButtonSelectionBlock:(void (^)(void))destructiveButtonSelectionBlock
{
    self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    
    if (self) {
        self.cancelButtonTitle = cancelButtonTitle;
        self.cancelButtonBlock = cancelButtonBlock;
        
        if (self.destructiveButtonIndex >= 0) {
            [self.blocksArray insertObject:[destructiveButtonSelectionBlock copy] atIndex:self.destructiveButtonIndex];
        }
    }
    
    return self;
}

- (NSInteger)addButtonWithTitle:(NSString *)title selectionBlock:(void (^)(void))block
{
    NSInteger buttonIndex = [super addButtonWithTitle:title];
    if (buttonIndex < [self.blocksArray count]) {
        [self.blocksArray insertObject:[block copy] atIndex:buttonIndex];
    }
    else {
        [self.blocksArray addObject:[block copy]];
    }
    return buttonIndex;
}

- (void)addCancelButton
{
    NSInteger cancelButtonIndex = [self addButtonWithTitle:self.cancelButtonTitle selectionBlock:self.cancelButtonBlock];
    self.cancelButtonIndex = cancelButtonIndex;
}

- (NSMutableArray *)blocksArray
{
    if (!_blocksArray) _blocksArray = [NSMutableArray array];
    return _blocksArray;
}

#pragma mark - Ovverrides for Cancel Button
// Must override this methods to show the cancel button in the correct place.

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated
{
    [self addCancelButton];
    [super showFromBarButtonItem:item animated:animated];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
    [self addCancelButton];
    [super showFromRect:rect inView:view animated:animated];
}

- (void)showFromTabBar:(UITabBar *)view
{
    [self addCancelButton];
    [super showFromTabBar:view];
}

- (void)showFromToolbar:(UIToolbar *)view
{
    [self addCancelButton];
    [super showFromToolbar:view];
}

- (void)showInView:(UIView *)view
{
    [self addCancelButton];
    [super showInView:view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void(^block)(void) = [self.blocksArray objectAtIndex:buttonIndex];
    if (block) {
        block();
    }
}

@end
