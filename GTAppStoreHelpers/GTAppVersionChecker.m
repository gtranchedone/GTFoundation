//
//  GTAppVersionChecker.m
//  iTunesLookupAPITest
//
//  Created by Gianluca Tranchedone on 18/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTAppVersionChecker.h"

static NSString * const iTunesLookupResultsArrayKey = @"results";
static NSString * const iTunesLookupApplicationVersionKey = @"version";
static NSString * const iTunesLookupAPIURLFormat = @"http://itunes.apple.com/lookup?id=%@&entity=software";

@interface GTAppVersionChecker ()

@property (nonatomic, copy) NSString *appleAppID;

@end

#pragma mark - Implementation

@implementation GTAppVersionChecker

@synthesize appleAppID = _appleAppID;

+ (GTAppVersionChecker *)versionCheckerWithAppleAppID:(NSString *)appleAppID
{
    GTAppVersionChecker *checker = [[GTAppVersionChecker alloc] initWithAppleAppID:appleAppID];
    return checker;
}

- (id)initWithAppleAppID:(NSString *)appleAppID
{
    self = [super init];
    if (self) {
        self.appleAppID = appleAppID;
    }
    return self;
}

- (void)openAppWithAppleID:(NSString *)appleAppID
{
    static NSString * const iTunesAppStoreURLFormat = @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@&mt=8";
    NSURL *appURL = [NSURL URLWithString:[NSString stringWithFormat:iTunesAppStoreURLFormat, appleAppID]];
    [[UIApplication sharedApplication] openURL:appURL];
}

- (void)checkLatestApplicationVersionWithCompletionBlock:(void (^)(BOOL, NSError *))completionBlock
{
    NSAssert(self.appleAppID != nil, ([NSString stringWithFormat:@"%@ needs the app's Apple Unique Identifier to check whether the installed version is the latest or not. Please set it up with the provided initializer or by using the provided class method to get an object correctly initialized.", NSStringFromClass(self.class)]));
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        BOOL isLatestVersion = NO;
        NSError *error = nil;
        
        NSURL *iTunesLookupURL = [NSURL URLWithString:[NSString stringWithFormat:iTunesLookupAPIURLFormat, self.appleAppID]];
        NSData *data = [NSData dataWithContentsOfURL:iTunesLookupURL];
        
        if (data) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSArray *resultsArray = [responseDict objectForKey:iTunesLookupResultsArrayKey];
            
            if ([resultsArray count]) {
                NSDictionary *appDictionary = [resultsArray objectAtIndex:0];
                NSString *appLatestVersion = [appDictionary objectForKey:iTunesLookupApplicationVersionKey];
                NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleVersionKey];
                isLatestVersion = [appVersion isEqualToString:appLatestVersion];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(isLatestVersion, error);
        });
    });
}

@end
