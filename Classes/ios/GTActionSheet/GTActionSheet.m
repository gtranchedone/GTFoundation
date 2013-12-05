//
//  GTActionSheet.m
//  GTFoundation
//
//  Created by Gianluca Tranchedone on 14/08/13.
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Gianluca Tranchedone
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "GTActionSheet.h"

#if TARGET_OS_IPHONE

@interface GTActionSheet () <UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *blocksArray;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, strong) void(^cancelButtonBlock)(void);

- (void)addCancelButton;

@end

#pragma mark -

@implementation GTActionSheet

#pragma mark - Public APIs -
#pragma mark Initialization

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
            if (destructiveButtonSelectionBlock) {
                [self.blocksArray insertObject:[destructiveButtonSelectionBlock copy] atIndex:self.destructiveButtonIndex];
            }
            else {
                [self.blocksArray insertObject:^{} atIndex:self.destructiveButtonIndex];
            }
        }
    }
    
    return self;
}

#pragma mark Adding Buttons

- (NSInteger)addButtonWithTitle:(NSString *)title selectionBlock:(void (^)(void))block
{
    NSInteger buttonIndex = [super addButtonWithTitle:title];
    if (block) {
        if (buttonIndex < [self.blocksArray count]) {
            [self.blocksArray insertObject:[block copy] atIndex:buttonIndex];
        }
        else {
            [self.blocksArray addObject:[block copy]];
        }
    }
    else {
        [self.blocksArray addObject:^{}];
    }
    
    return buttonIndex;
}

#pragma mark - Private APIs -

- (void)addCancelButton
{
    NSInteger cancelButtonIndex = [self addButtonWithTitle:self.cancelButtonTitle selectionBlock:self.cancelButtonBlock];
    self.cancelButtonIndex = cancelButtonIndex;
}

#pragma mark - Ovverrides for Cancel Button -
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

#pragma mark - UIActionSheetDelegate -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void(^block)(void) = [self.blocksArray objectAtIndex:buttonIndex];
    if (block) {
        block();
    }
}

#pragma mark - Setters and Getters -

- (NSMutableArray *)blocksArray
{
    if (!_blocksArray) _blocksArray = [NSMutableArray array];
    return _blocksArray;
}

@end

#endif
