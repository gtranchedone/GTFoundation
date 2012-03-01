//
//  UIImage+ScreenCapture.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 05/12/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "UIImage+ScreenCapture.h"

@implementation UIImage (ScreenCapture)

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;        
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) 
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) 
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        }
        else 
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }       
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) 
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef cropped = CGImageCreateWithImageInRect(imageToCrop.CGImage, rect);
    UIImage *retImage = [UIImage imageWithCGImage: cropped];
    CGImageRelease(cropped);
    
    return retImage;
}

+ (UIImage *)captureRect:(CGRect)rect inView:(UIView *)view
{
    CGRect rectToCapture = rect;
    BOOL needsCropping = (rect.origin.x != 0 || rect.origin.y != 0);
    
    if (needsCropping) {
        rectToCapture = [[UIScreen mainScreen] bounds];
    }
    
    UIGraphicsBeginImageContext(rectToCapture.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor blackColor] set];
    CGContextFillRect(context, rectToCapture);
    [view.layer renderInContext:context];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    if (needsCropping) {
        return [UIImage imageByCropping:newImage toRect:rect];
    }
    else {
        return newImage;
    }
}

+ (UIImage *)captureView:(UIView *)view
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    return [self captureRect:screenRect inView:view];
}

@end
