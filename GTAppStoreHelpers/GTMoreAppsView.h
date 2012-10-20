//
//  GTMoreAppsView.h
//  iTunesLookupAPITest
//
//  Created by Gianluca Tranchedone on 15/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GTMoreAppsView : UIView

@property (nonatomic, strong) NSArray *apps; // array of GTApp objects.

- (void)lookupAppsWithDeveloperID:(NSString *)developerID completionBlock:(void(^)(NSArray *lookupResults))completionBlock;

@end

#pragma mark - GTApp Class Interface

@interface GTApp : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSURL *appStoreURL;
@property (nonatomic, copy) NSString *bundleIdentifier;

- (void)open; // opens the application.
- (void)viewOnAppStore; // opens the the application's page on the App Store app.
- (BOOL)isAppInstalledOnDevice; // it assumes that the app has defined a url scheme formatted as '[bundleID]://'
- (NSDictionary *)dictionaryForm;

@end
