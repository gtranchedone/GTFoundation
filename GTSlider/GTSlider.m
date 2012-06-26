//
//  GTSlider.m
//  GTSliderController
//
//  Created by Gianluca Tranchedone on 21/08/11.
//  Copyright 2012 SketchToCode. All rights reserved.
//

#import "GTSlider.h"

@interface GTSlider ()

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIViewController *sliderValueController;

- (void)initialize;
- (void)sliderValueChanged;

@end

@implementation GTSlider

@synthesize delegate = delegate_;
@synthesize popover = popover_;
@synthesize valueLabel = valueLabel_;
@synthesize sliderValueController = sliderValueController_;


- (id)init
{
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize
{
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)];
    self.valueLabel.backgroundColor = [UIColor darkGrayColor];
    self.valueLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLabel.textColor = [UIColor whiteColor];
    
    self.sliderValueController = [[UIViewController alloc] init];
    self.sliderValueController.view.frame = self.valueLabel.frame;
    [self.sliderValueController.view addSubview:self.valueLabel];
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:self.sliderValueController];
    self.popover.popoverContentSize = self.sliderValueController.view.frame.size;
    
    [self addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)setPopoverLabelText:(NSString *)text
{
    self.valueLabel.text = text;
}

- (void)sliderValueChanged
{
    self.valueLabel.text = [NSString stringWithFormat:@"%.3f", self.value];
    
    CGFloat sliderMin =  self.minimumValue;
	CGFloat sliderMax = self.maximumValue;
	CGFloat sliderMaxMinDiff = sliderMax - sliderMin;
	CGFloat sliderValue = self.value;
	
	if(sliderMin < 0.0) {
        
		sliderValue = self.value-sliderMin;
		sliderMax = sliderMax - sliderMin;
		sliderMin = 0.0;
		sliderMaxMinDiff = sliderMax - sliderMin;
	}
	
	CGFloat xCoord = ((sliderValue - sliderMin) / sliderMaxMinDiff) * self.frame.size.width - self.sliderValueController.view.frame.size.width / 2.0;
	
	CGFloat halfMax = (sliderMax+sliderMin)/2.0;
	
	if(sliderValue > halfMax) {
		
		sliderValue = (sliderValue - halfMax)+(sliderMin*1.0);
		sliderValue = sliderValue/halfMax;
		sliderValue = sliderValue*11.0;
		
		xCoord = xCoord - sliderValue;
	}
	
	else if(sliderValue <  halfMax) {
		
		sliderValue = (halfMax - sliderValue)+(sliderMin*1.0);
		sliderValue = sliderValue/halfMax;
		sliderValue = sliderValue*11.0;
		
		xCoord = xCoord + sliderValue;
	}
    
    [self.popover presentPopoverFromRect:CGRectMake(xCoord, 0.0, self.popover.popoverContentSize.width, self.popover.popoverContentSize.height) inView:self permittedArrowDirections:UIPopoverArrowDirectionDown animated:NO];

    if ([self.delegate conformsToProtocol:@protocol(GTSliderDelegate)]) {
        [self.delegate sliderValueDidChange];
    }
}

@end
