//
//  UIImage+ScreenCapture.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 05/12/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (ScreenCapture)

+ (UIImage *)captureRect:(CGRect)rect inView:(UIView *)view;
+ (UIImage *)captureView:(UIView *)view;

@end
