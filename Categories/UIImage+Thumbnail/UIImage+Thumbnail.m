//
//  UIImage+Thumbnail.m
//  MoneyClip
//
//  Created by Gianluca Tranchedone on 18/05/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "UIImage+Thumbnail.h"

@implementation UIImage (Thumbnail)

- (UIImage *)thumbnailOfSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newThumbnail;
}

@end
