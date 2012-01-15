//
//  GTGuideViewController.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 06/12/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NSString * const GTGuideViewTitleKey;
NSString * const GTGuideViewImageKey;
NSString * const GTGuideViewTextKey;

@protocol GTGuideViewControllerDelegate;

@interface GTGuideViewController : UIViewController {
    
}

@property (nonatomic, unsafe_unretained) id<GTGuideViewControllerDelegate> delegate;

@end

//_________________________________________________

@protocol GTGuideViewControllerDelegate <NSObject>

- (NSUInteger)numberOfPagesInGuide:(GTGuideViewController *)guide;
- (NSDictionary *)guide:(GTGuideViewController *)guide detailsForViewAtIndex:(NSInteger)index;

@optional
- (void)guide:(GTGuideViewController *)guide didMoveToPageAtIndex:(NSInteger)index;

@end
