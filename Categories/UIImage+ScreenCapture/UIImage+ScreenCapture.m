//
//  UIImage+ScreenCapture.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 05/12/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "UIImage+ScreenCapture.h"

@implementation UIImage (ScreenCapture)

+ (UIImage *)captureRect:(CGRect)rect inView:(UIView *)view
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor blackColor] set];
    CGContextFillRect(context, rect);
    [view.layer renderInContext:context];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)captureView:(UIView *)view
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [view.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
