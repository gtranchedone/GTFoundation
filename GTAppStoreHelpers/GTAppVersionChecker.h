//
//  GTAppVersionChecker.h
//  iTunesLookupAPITest
//
//  Created by Gianluca Tranchedone on 18/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @class that asyncronusly checks whether the version of the app in use is the lastest available on the AppStore.
 If an error occures (es. no Internet connection is available), an NSError object is given in passed to the completionBlock.
 
 NOTE: since there's no other way to get this information, as far as I know at least, you need to create an object of this class 
 with one of the methods listed below, in order to set the app's apple identifier needed to perform the check.
 If no appleAppID is set an exeptions is rised.
 */

@interface GTAppVersionChecker : NSObject

+ (GTAppVersionChecker *)versionCheckerWithAppleAppID:(NSString *)appleAppID; /** @param appleAppID is the Apple's app identifier */

- (id)initWithAppleAppID:(NSString *)appleAppID; /** @param appleAppID is the Apple's app identifier */

- (void)giftApp;
- (void)reviewApp;
- (void)seeAppOnAppStore;
- (void)checkLatestApplicationVersionWithCompletionBlock:(void(^)(BOOL isLatestVersion, NSError *error))completionBlock;

@end
