//
//  GTAmountField.h
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 30/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+ColorsAddition.h"

#define GT_INCOME_TEXT_COLOR [UIColor colorFromRGBWithRed:143 green:194 blue:72 andAlpha:1]
#define GT_EXPENSES_TEXT_COLOR [UIColor lightCoralColor]

@protocol GTAmountFieldDelegate;

@interface GTAmountField : UIView

// TODO: make it more reusable by letting set the amountButtonImages.

@property (nonatomic, assign) id<GTAmountFieldDelegate> delegate;

/**
 @property 'amount' can be set to manually change the value displayed on this view's field. The default value is 0,00.
 */
@property (nonatomic, weak) NSDecimalNumber *amount;

/**
 @property 'negativeAmount' can be used to know whether the value currently displayed on this view's field is negative or not.
 */
@property (nonatomic, readonly, getter = isNegativeAmount) BOOL negativeAmount;

/**
 @property 'currency' returns the current currency in use. Setting it will cause the keyboard's currency button title to change to
 the newly set currency code.
 */
@property (nonatomic, strong) NSString *currency;

/**
 Appearance
 */
@property (nonatomic, assign) UIFont *font;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) UIColor *shadowColor;
@property (nonatomic, assign) CGFloat minimumFontScale;

@end

// MCAmountFieldDelegate

@protocol GTAmountFieldDelegate <NSObject>

@optional
- (BOOL)amountFieldShouldBeginEditing:(GTAmountField *)amountField;

- (void)amountFieldDidPressEnterKey:(GTAmountField *)amountField;
- (void)amountFieldDidPressCurrencyKey:(GTAmountField *)amountField;
- (void)amountField:(GTAmountField *)amountField didSetNewAmount:(NSDecimalNumber *)amount;

@end
