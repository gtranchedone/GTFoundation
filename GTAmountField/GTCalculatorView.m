//
//  GTCalculatorView.m
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 10/05/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTCalculatorView.h"
#import "NSNumberFormatter+SharedFormatter.h"

@interface GTCalculatorView ()

@property (nonatomic, strong) IBOutlet UILabel *displayLabel;
@property (nonatomic, readwrite, assign) NSDecimalNumber *currentValue;

@end

#pragma mark - Implementation

@implementation GTCalculatorView

@synthesize currentValue = _currentValue;
@synthesize displayLabel = _displayLabel;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame initialValue:[NSDecimalNumber zero]];
}

- (id)initWithFrame:(CGRect)frame initialValue:(NSDecimalNumber *)initialValue
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentValue = initialValue;
    }
    return self;
}

#pragma mark - Setters and Getters

- (void)setCurrentValue:(NSDecimalNumber *)currentValue
{
    self.displayLabel.text = [[NSNumberFormatter decimalFormatter] stringFromNumber:currentValue];
}

- (NSDecimalNumber *)currentValue
{
    NSNumber *unformattedNumber = [[NSNumberFormatter decimalFormatter] numberFromString:self.displayLabel.text];
    return [NSDecimalNumber decimalNumberWithString:[unformattedNumber stringValue]];
}

@end
