//
//  GTSpinnerButton.m
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 01/05/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTSpinnerButton.h"

@implementation GTSpinnerButton

@synthesize spinner = _spinner;

- (void)startSpinner
{
    self.enabled = NO;
    [self.spinner startAnimating];
    [self addSubview:self.spinner];
    [self.imageView removeFromSuperview];
}

- (void)stopSpinner
{
    self.enabled = YES;
    [self.spinner stopAnimating];
    [self addSubview:self.imageView];
    [self.spinner removeFromSuperview];
}

- (UIActivityIndicatorView *)spinner
{
    if (!_spinner) {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        spinner.center = (CGPoint){self.bounds.size.width / 2, self.bounds.size.height / 2};
        self.spinner = spinner;
    }
    
    return _spinner;
}

@end
