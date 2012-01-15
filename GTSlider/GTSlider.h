//
//  GTSlider.h
//  GTSliderController
//
//  Created by Gianluca Tranchedone on 21/08/11.
//  Copyright 2012 SketchToCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GTSliderDelegate;

@interface GTSlider : UISlider {
    
}

@property (nonatomic, unsafe_unretained) id<GTSliderDelegate> delegate;
@property (nonatomic, strong) UIPopoverController *popover;

- (void)setPopoverLabelText:(NSString *)text;

@end

@protocol GTSliderDelegate <NSObject>

- (void)sliderValueDidChange;

@end