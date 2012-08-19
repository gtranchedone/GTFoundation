//
//  GTAmountKeyboard.h
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 30/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GTAmountKeyboardDelegate;

@interface GTAmountKeyboard : UIView

@property (nonatomic, weak) id<GTAmountKeyboardDelegate> delegate;

+ (GTAmountKeyboard *)sharedKeyboard;

- (void)show;
- (void)hide;
- (void)setCurrencyKeyTitle:(NSString *)currencyKeyTitle;

@end

// GTAmountKeyboardDelegate

@protocol GTAmountKeyboardDelegate <NSObject>

- (void)keyboard:(GTAmountKeyboard *)keyboard didEnterDigit:(NSString *)digit;
- (void)keyboard:(GTAmountKeyboard *)keyboard didPressSignButton:(UIButton *)sender;
- (void)keyboard:(GTAmountKeyboard *)keyboard didPressEnterButton:(UIButton *)sender;
- (void)keyboard:(GTAmountKeyboard *)keyboard didPressClearButton:(UIButton *)sender;
- (void)keyboard:(GTAmountKeyboard *)keyboard didPressCancelButton:(UIButton *)sender;
- (void)keyboard:(GTAmountKeyboard *)keyboard didPressCurrencyButton:(UIButton *)sender;
- (void)keyboard:(GTAmountKeyboard *)keyboard didPressCalculatorButton:(UIButton *)sender;

@end
