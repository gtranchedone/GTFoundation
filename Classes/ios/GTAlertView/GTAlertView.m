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

#if TARGET_OS_IPHONE

#import "GTAlertView.h"

@interface GTAlertView () <UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *blocksArray;

@end

#pragma mark - Implementation

@implementation GTAlertView

@synthesize blocksArray = _blocksArray;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButton
{
    return [self initWithTitle:title message:message cancelButtonTitle:cancelButton cancelBlock:^{}];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButton cancelBlock:(void (^)(void))cancelBlock
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButton otherButtonTitles:nil];
    if (self) {
        self.blocksArray = [NSMutableArray array];
        [self.blocksArray addObject:[cancelBlock copy]];
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title selectionBlock:(void (^)(void))selectionBlock
{
    [super addButtonWithTitle:title];
    [self.blocksArray addObject:[selectionBlock copy]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void(^block)(void) = [self.blocksArray objectAtIndex:buttonIndex];
    if (block) {
        block();
    }
}

@end

#endif
