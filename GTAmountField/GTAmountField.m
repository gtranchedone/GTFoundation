//
//  GTAmountField.m
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 30/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTAmountField.h"

#import "GTAmountKeyboard.h"
#import "GTUtilityFunctions.h"
#import "NSDecimalNumber+Opposite.h"
#import "NSNumberFormatter+SharedFormatter.h"

static NSString * const MaximumNumberAllowed = @"999999999999";

@interface GTAmountField () <GTAmountKeyboardDelegate>

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, readwrite) BOOL negativeAmount;
@property (nonatomic, strong) GTAmountKeyboard *keyboard;

- (void)setup;
- (void)changeAmountSign;

@end

#pragma mark - Implementation

@implementation GTAmountField

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setAmount:[NSDecimalNumber zero]];
    self.font = [UIFont boldSystemFontOfSize:40];
    self.minimumFontScale = 0.5;
    
    [self addSubview:self.textLabel];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    if ([self.delegate respondsToSelector:@selector(amountFieldShouldBeginEditing:)]) {
        if ([self.delegate amountFieldShouldBeginEditing:self]) {
            [self.keyboard show];
            return [super becomeFirstResponder];
        }
        else {
            return NO;
        }
    }
    else {
        [self.keyboard show];
        return [super becomeFirstResponder];
    }
}

- (BOOL)resignFirstResponder
{
    [self.keyboard hide];
    
    return [super resignFirstResponder];
}

- (void)changeAmountSign
{
    self.negativeAmount = !self.negativeAmount;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self becomeFirstResponder];
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (!newWindow) {
        [self resignFirstResponder];
    }
}

#pragma mark - GTAmountKeyboardDelegate

- (void)keyboard:(GTAmountKeyboard *)keyboard didEnterDigit:(NSString *)digit
{
    NSString *newText = self.textLabel.text;
    NSDecimalNumberHandler *behaviour = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2
                                                                                    raiseOnExactness:NO raiseOnOverflow:NO 
                                                                                    raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    // since we multiply the value extracted from the textField by 10, if the new digit is 0 we don't need to do anything
    if (![digit isEqualToString:[[NSDecimalNumber zero] stringValue]]) {
        if (![digit isEqualToString:@"100"]) {
            newText = [self.textLabel.text stringByAppendingString:digit];
        }
    }
    
    // get the current textField value and multiply by 10 or 100
    NSString *multiplier = [digit isEqualToString:@"100"] ? @"100" : @"10";
    NSString *unformattedAmount = [[[NSNumberFormatter decimalFormatter] numberFromString:newText] stringValue];
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:unformattedAmount];
    amount = [amount decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:multiplier] withBehavior:behaviour]; 
    newText = [[NSNumberFormatter decimalFormatter] stringFromNumber:amount];
    
    // this is done to prevent the nsdecimalnumber's overflow exeption to trigger
    if (!([amount compare:[NSDecimalNumber decimalNumberWithString:MaximumNumberAllowed]] == NSOrderedDescending)) {
        self.textLabel.text = newText;
    }
    
    // notify the delegate
    if ([self.delegate respondsToSelector:@selector(amountField:didSetNewAmount:)]) {
        [self.delegate amountField:self didSetNewAmount:self.amount];
    }
}

- (void)keyboard:(GTAmountKeyboard *)keyboard didPressCancelButton:(UIButton *)sender
{
    NSDecimalNumberHandler *behaviour = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2
                                                                                    raiseOnExactness:NO raiseOnOverflow:NO 
                                                                                    raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSString *unformattedAmount = [[[NSNumberFormatter decimalFormatter] numberFromString:self.textLabel.text] stringValue];
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:unformattedAmount];
    amount = [amount decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10"] withBehavior:behaviour];    
    
    self.textLabel.text = [[NSNumberFormatter decimalFormatter] stringFromNumber:amount];
    if ([self.delegate respondsToSelector:@selector(amountField:didSetNewAmount:)]) {
        [self.delegate amountField:self didSetNewAmount:self.amount];
    }
}

- (void)keyboard:(GTAmountKeyboard *)keyboard didPressClearButton:(UIButton *)sender 
{
    self.textLabel.text = [[NSNumberFormatter decimalFormatter] stringFromNumber:[NSNumber numberWithDouble:0.0]];
    if ([self.delegate respondsToSelector:@selector(amountField:didSetNewAmount:)]) {
        [self.delegate amountField:self didSetNewAmount:self.amount];
    }
}

- (void)keyboard:(GTAmountKeyboard *)keyboard didPressEnterButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(amountFieldDidPressEnterKey:)]) {
        [self.delegate amountFieldDidPressEnterKey:self];
    }
    else {
        [self.keyboard hide];
    }
}

- (void)keyboard:(GTAmountKeyboard *)keyboard didPressSignButton:(UIButton *)sender
{
    self.amount = [self.amount oppositeValue];
}

- (void)keyboard:(GTAmountKeyboard *)keyboard didPressCurrencyButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(amountFieldDidPressCurrencyKey:)]) {
        [self.delegate amountFieldDidPressCurrencyKey:self];
    }
}

- (void)keyboard:(GTAmountKeyboard *)keyboard didPressCalculatorButton:(UIButton *)sender
{
    TODO
}

#pragma mark - Setters and Getters

- (GTAmountKeyboard *)keyboard
{
    if (!_keyboard) {
        self.keyboard = [GTAmountKeyboard sharedKeyboard];
        self.keyboard.delegate = self;
    }
    
    return _keyboard;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentRight;
        textLabel.shadowOffset = CGSizeMake(0.0, 0.5);
        textLabel.shadowColor = [UIColor whiteColor];
        textLabel.adjustsFontSizeToFitWidth = YES;
        
        self.textLabel = textLabel;
    }
    
    return _textLabel;
}

- (void)setAmount:(NSDecimalNumber *)amount
{
    if ([amount isEqualToNumber:[NSDecimalNumber zero]]) {
        self.negativeAmount = !self.negativeAmount;
        self.textLabel.text = [[NSNumberFormatter decimalFormatter] stringFromNumber:[NSDecimalNumber zero]];
    }
    else {
        self.negativeAmount = [amount doubleValue] < 0;
        NSString *amountAsString = [[NSNumberFormatter decimalFormatter] stringFromNumber:amount];
        
        if (self.negativeAmount) {
            amountAsString = [amountAsString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        
        self.textLabel.text = amountAsString;
    }
    
    if (!self.negativeAmount) {
        self.textLabel.textColor = GT_INCOME_TEXT_COLOR;
    }
    else {
        self.textLabel.textColor = GT_EXPENSES_TEXT_COLOR;
    }
    
    if (self.textLabel.text) {
        if ([self.delegate respondsToSelector:@selector(amountField:didSetNewAmount:)]) {
            [self.delegate amountField:self didSetNewAmount:self.amount];
        }
    }
}

- (NSDecimalNumber *)amount
{
    /**
     to get an unformatted number from a string as a string you first need to get a number from the source string and
     then convert it to a string calling the number's -stringValue method.
     */
    NSNumber *formattedAmount = [[NSNumberFormatter decimalFormatter] numberFromString:self.textLabel.text];
    NSString *unformattedAmount = [formattedAmount stringValue];
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:unformattedAmount];
    
    if (self.negativeAmount) {
        amount = [amount oppositeValue];
    }
    
    return amount;
}

- (void)setCurrency:(NSString *)currency
{
    NSArray *currencyCodes = [NSLocale commonISOCurrencyCodes];
    if ([currencyCodes containsObject:currency]) {
        _currency = currency;
        [self.keyboard setCurrencyKeyTitle:CurrencySymbolFromCurrencyCode(currency)];
    }
}

- (void)setFont:(UIFont *)font
{
    self.textLabel.font = font;
}

- (UIFont *)font
{
    return self.textLabel.font;
}

- (void)setMinimumFontScale:(CGFloat)minimumFontScale
{
    self.textLabel.minimumScaleFactor = minimumFontScale;
}

- (CGFloat)minimumFontScale
{
    return self.textLabel.minimumScaleFactor;
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    self.textLabel.shadowOffset = shadowOffset;
}

- (CGSize)shadowOffset
{
    return self.textLabel.shadowOffset;
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    self.textLabel.shadowColor = shadowColor;
}

- (UIColor *)shadowColor
{
    return self.textLabel.shadowColor;
}

@end
