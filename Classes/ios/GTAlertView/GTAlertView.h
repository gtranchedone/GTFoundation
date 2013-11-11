//
//  GTAlertView.h
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

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

/**
 @abstract GTAlertView is a subclass of UIAlertView that takes advantage of blocks to add to its superclass block-based and utility APIs.
 */
@interface GTAlertView : UIAlertView {
    @private
    NSMutableArray *_blocksArray;
}

///--------------------------------------------------
/// @name Presenting a block-based alertView
///--------------------------------------------------

/**
 @abstract Creates and presents an alertView initialized with the passed-in values.
 @param title The title of the alertView.
 @param message A descriptive message that provides more info than the title of the alert.
 @param cancelButtonTitle The title of the cancel button or nil if there's no cancel button.
 @see +[GTAlertView showAlertWithTitle:message:cancelButtonTitle:cancelBlock:firstOtherButtonTitle:firstOtherButtonBlock:]
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

/**
 @abstract Creates and presents an alertView initialized with the passed-in values.
 @param title The title of the alertView.
 @param message A descriptive message that provides more info than the title of the alert.
 @param cancelButtonTitle The title of the cancel button or nil if there's no cancel button.
 @param cancelBlock A block that's called when the cancel button is pressed or nil if no action should be performed.
 @see +[GTAlertView showAlertWithTitle:message:cancelButtonTitle:cancelBlock:firstOtherButtonTitle:firstOtherButtonBlock:]
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)(void))cancelBlock;

/**
 @abstract Creates and presents an alertView initialized with the passed-in values.
 @param title The title of the alertView.
 @param message A descriptive message that provides more info than the title of the alert.
 @param cancelButtonTitle The title of the cancel button or nil if there's no cancel button.
 @param firstButtonTitle The title of the first non-cancel button or nil if there's no other button.
 @param block A block that's called when the first non-cancel button is pressed or nil if no action should be performed.
 @see +[GTAlertView showAlertWithTitle:message:cancelButtonTitle:cancelBlock:firstOtherButtonTitle:firstOtherButtonBlock:]
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle firstOtherButtonTitle:(NSString *)firstButtonTitle firstOtherButtonBlock:(void(^)(void))block;

/**
 @abstract Creates and presents an alertView initialized with the passed-in values.
 @param title The title of the alertView.
 @param message A descriptive message that provides more info than the title of the alert.
 @param cancelButtonTitle The title of the cancel button or nil if there's no cancel button.
 @param cancelBlock A block that's called when the cancel button is pressed or nil if no action should be performed.
 @param firstButtonTitle The title of the first non-cancel button or nil if there's no other button.
 @param block A block that's called when the first non-cancel button is pressed or nil if no action should be performed.
 @see -[GTAlertView initWithTitle:message:cancelButtonTitle:cancelBlock:firstOtherButtonTitle:firstOtherButtonBlock:]
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)(void))cancelBlock firstOtherButtonTitle:(NSString *)firstButtonTitle firstOtherButtonBlock:(void(^)(void))block;

///--------------------------------------------------
/// @name Creating an instance
///--------------------------------------------------

/**
 @abstract Creates a new alertView initialized with the passed-in values.
 @param title The title of the alertView.
 @param message A descriptive message that provides more info than the title of the alert.
 @param cancelButtonTitle The title of the cancel button or nil if there's no cancel button.
 @return A new instance of the class initalized with the passed-in parameters.
 @see -[GTAlertView initWithTitle:message:cancelButtonTitle:cancelBlock:firstOtherButtonTitle:firstOtherButtonBlock:]
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

/**
 @abstract Creates a new alertView initialized with the passed-in values.
 @param title The title of the alertView.
 @param message A descriptive message that provides more info than the title of the alert.
 @param cancelButtonTitle The title of the cancel button or nil if there's no cancel button.
 @param cancelBlock A block that's called when the cancel button is pressed or nil if no action should be performed.
 @return A new instance of the class initalized with the passed-in parameters.
 @see -[GTAlertView initWithTitle:message:cancelButtonTitle:cancelBlock:firstOtherButtonTitle:firstOtherButtonBlock:]
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)(void))cancelBlock;

/**
 @abstract Creates a new alertView initialized with the passed-in values.
 @param title The title of the alertView.
 @param message A descriptive message that provides more info than the title of the alert.
 @param cancelButtonTitle The title of the cancel button or nil if there's no cancel button.
 @param firstButtonTitle The title of the first non-cancel button or nil if there's no other button.
 @param block A block that's called when the first non-cancel button is pressed or nil if no action should be performed.
 @return A new instance of the class initalized with the passed-in parameters.
 @see -[GTAlertView initWithTitle:message:cancelButtonTitle:cancelBlock:firstOtherButtonTitle:firstOtherButtonBlock:]
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle firstOtherButtonTitle:(NSString *)firstButtonTitle firstOtherButtonBlock:(void(^)(void))block;

/**
 @abstract Creates a new alertView initialized with the passed-in values.
 @param title The title of the alertView.
 @param message A descriptive message that provides more info than the title of the alert.
 @param cancelButtonTitle The title of the cancel button or nil if there's no cancel button.
 @param cancelBlock A block that's called when the cancel button is pressed or nil if no action should be performed.
 @param firstButtonTitle The title of the first non-cancel button or nil if there's no other button.
 @param block A block that's called when the first non-cancel button is pressed or nil if no action should be performed.
 @return A new instance of the class initalized with the passed-in parameters.
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)(void))cancelBlock firstOtherButtonTitle:(NSString *)firstButtonTitle firstOtherButtonBlock:(void(^)(void))block;

///--------------------------------------------------
/// @name Adding buttons to the alertView
///--------------------------------------------------

/**
 @abstract Adds a button to the alertView. The block passed in this method is associated with the button and it's called when the button is pressed.
 @throws An exeption is thrown if you pass nil or an empty string for the title parameter.
 @param title The new button's title. This paramenter cannot be nil or an empty string.
 @param selectionBlock The block that should be called when the button is pressed. This parameter can be nil.
 @see -[UIAlertView addButtonWithTitle:]
 */
- (void)addButtonWithTitle:(NSString *)title selectionBlock:(void(^)(void))selectionBlock;

@end

#endif
