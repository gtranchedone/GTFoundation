//
//  GTFramework.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 17/12/11.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

typedef void(^gt_empty_completion_block)(void);

// Frameworks
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioServices.h>

// Classes
#import "GTSlider.h"
#import "GTAlertView.h"
#import "GTPagingView.h"
#import "GTActionSheet.h"
#import "GTTextViewCell.h"
#import "GTMoreAppsView.h"
#import "GTAppStoreHelper.h"
#import "GTMapViewController.h"
#import "GTGuideViewController.h"
#import "GTManagedObjectSelector.h"
#import "GTPasscodeViewController.h"
#import "GTDetailEditingViewController.h"

// Categories
#import "NSDate+Utilities.h"
#import "UIImage+ScreenCapture.h"
#import "UIColor+ColorsAddition.h"
#import "NSManagedObject+FirstLetter.h"
#import "NSDateFormatter+SharedFormatter.h"
#import "NSNumberFormatter+SharedFormatter.h"
#import "MFMailComposeViewController+FastInit.h"
