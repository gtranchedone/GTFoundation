//
//  GTAmountKeyboard.m
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 30/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTAmountKeyboard.h"
#import "UIView+GTExtentions.h"

static GTAmountKeyboard * sharedInstance = nil;

static CGFloat const kKeyboardWidth = 320.0f;
static CGFloat const kKeyboardHeight = 217.0f;
static NSString * const kKeyboardXIBName = @"GTAmountKeyboard";

@interface GTAmountKeyboard ()

@property (nonatomic, weak) IBOutlet UIButton *signButton;
@property (nonatomic, weak) IBOutlet UIButton *currencyButton;

- (void)loadView;
- (IBAction)enterDigit:(UIButton *)sender;
- (IBAction)signButtonPressed:(UIButton *)sender;
- (IBAction)enterButtonPressed:(UIButton *)sender;
- (IBAction)clearButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)currencyButtonPressed:(UIButton *)sender;
- (IBAction)calculatorButtonPressed:(UIButton *)sender;

@end

@implementation GTAmountKeyboard

@synthesize delegate = _delegate;
@synthesize signButton = _signButton;
@synthesize currencyButton = _currencyButton;

#pragma mark - Initialization and Setup

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self loadView];
}

- (void)loadView {
    UIView *keyboard = [[[NSBundle mainBundle] loadNibNamed:kKeyboardXIBName owner:self options:nil] objectAtIndex:0];
    keyboard.backgroundColor = [UIColor clearColor];
    [self addShadowWithOffset:(CGSize){0.0, -0.5}];
    [self addSubview:keyboard];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = (CGSize){kKeyboardWidth, kKeyboardHeight}; // force size;
    [super setFrame:frame];
}

- (void)drawRect:(CGRect)rect
{
    // draw background
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 1.0};
    
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1].CGColor,
                       (id)[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1].CGColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    // draw top line
    [[UIColor darkGrayColor] set];
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, rect.size.width, 0.0);
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - Public APIs

+ (GTAmountKeyboard *)sharedKeyboard
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GTAmountKeyboard alloc] initWithFrame:CGRectZero];
    });
    
    return sharedInstance;
}

- (void)show
{
    if (!self.window) {
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        
        // put the keyboard off screen
        self.frame = (CGRect){0.0, window.bounds.size.height, self.frame.size};
        [window addSubview:self];
        
        // calculate the new frame
        CGRect frame = (CGRect){0.0, window.bounds.size.height - self.frame.size.height, self.frame.size};
        
        // animate the keyboard to be shown on screen
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = frame;
        }];
    }
}

- (void)hide
{
    // animate the view to disappear and remove it from it's superview
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = (CGRect){0.0, self.window.frame.size.height, self.frame.size};
    } completion:^(BOOL finish){
        if (finish) {
            [self removeFromSuperview];
        }
    }];
}

- (void)setCurrencyKeyTitle:(NSString *)currencyKeyTitle
{
    [self.currencyButton setTitle:currencyKeyTitle forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)enterDigit:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(keyboard:didEnterDigit:)]) {
        [self.delegate keyboard:self didEnterDigit:[NSString stringWithFormat:@"%d", sender.tag]];
    }
}

- (IBAction)signButtonPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(keyboard:didPressSignButton:)]) {
        [self.delegate keyboard:self didPressSignButton:sender];
    }
}

- (IBAction)enterButtonPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(keyboard:didPressEnterButton:)]) {
        [self.delegate keyboard:self didPressEnterButton:sender];
    }
}

- (IBAction)clearButtonPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(keyboard:didPressClearButton:)]) {
        [self.delegate keyboard:self didPressClearButton:sender];
    }
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(keyboard:didPressCancelButton:)]) {
        [self.delegate keyboard:self didPressCancelButton:sender];
    }
}

- (IBAction)currencyButtonPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(keyboard:didPressCurrencyButton:)]) {
        [self.delegate keyboard:self didPressCurrencyButton:sender];
    }
}

- (IBAction)calculatorButtonPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(keyboard:didPressCalculatorButton:)]) {
        [self.delegate keyboard:self didPressCalculatorButton:sender];
    }
}

@end
