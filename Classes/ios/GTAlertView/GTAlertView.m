//
//  GTAlertView.m
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

#import "GTAlertView.h"

#if TARGET_OS_IPHONE

@interface GTAlertView () <UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *blocksArray;

@end


@implementation GTAlertView

#pragma mark - Public APIs -
#pragma mark Presenting an Alert View

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    GTAlertView *alertView = [[self alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle];
    [alertView show];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)(void))cancelBlock
{
    GTAlertView *alertView = [[self alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle cancelBlock:cancelBlock];
    [alertView show];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle firstOtherButtonTitle:(NSString *)firstButtonTitle firstOtherButtonBlock:(void(^)(void))block
{
    GTAlertView *alertView = [[self alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle firstOtherButtonTitle:firstButtonTitle firstOtherButtonBlock:block];
    [alertView show];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)(void))cancelBlock firstOtherButtonTitle:(NSString *)firstButtonTitle firstOtherButtonBlock:(void(^)(void))block
{
    GTAlertView *alertView = [[self alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle cancelBlock:cancelBlock firstOtherButtonTitle:firstButtonTitle firstOtherButtonBlock:block];
    [alertView show];
}

#pragma mark Initialization

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButton
{
    return [self initWithTitle:title message:message cancelButtonTitle:cancelButton cancelBlock:nil];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void (^)(void))cancelBlock
{
    return [self initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle cancelBlock:cancelBlock firstOtherButtonTitle:nil firstOtherButtonBlock:nil];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle firstOtherButtonTitle:(NSString *)firstButtonTitle firstOtherButtonBlock:(void(^)(void))block
{
    return [self initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle cancelBlock:nil firstOtherButtonTitle:firstButtonTitle firstOtherButtonBlock:block];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)(void))cancelBlock firstOtherButtonTitle:(NSString *)firstButtonTitle firstOtherButtonBlock:(void(^)(void))block
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self) {
        self.blocksArray = [NSMutableArray array];
        if (cancelBlock) {
            [self.blocksArray addObject:[cancelBlock copy]];
        }
        else {
            [self.blocksArray addObject:^{}];
        }
        
        if (firstButtonTitle) {
            [self addButtonWithTitle:firstButtonTitle selectionBlock:block];
        }
    }
    return self;
}

#pragma mark Adding Buttons

- (void)addButtonWithTitle:(NSString *)title selectionBlock:(void (^)(void))selectionBlock
{
    [super addButtonWithTitle:title];
    
    if (selectionBlock) {
        [self.blocksArray addObject:[selectionBlock copy]];
    }
    else {
        [self.blocksArray addObject:^{}];
    }
}

#pragma mark - UIAlertViewDelegate -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void(^block)(void) = [self.blocksArray objectAtIndex:buttonIndex];
    if (block) {
        block();
    }
}

@end

#endif
