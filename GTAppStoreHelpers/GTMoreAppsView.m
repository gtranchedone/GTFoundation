//
//  GTMoreAppsView.m
//  iTunesLookupAPITest
//
//  Created by Gianluca Tranchedone on 15/04/12.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTMoreAppsView.h"

static CGFloat kViewMargin = 10.0f;
static CGFloat kItemsMargin = 20.0f;
static CGSize kItemsSize = (CGSize){55.0f, 55.0f};

static NSString * const kCacheFolderName = @"GTMoreApps";
static NSString * const kMoreAppsCacheFileName = @"MoreAppsCache";
static NSString * const kCachedDeveloperIDKey = @"kCachedDeveloperIDKey";

// Apple returned JSON dictionary keys
static NSString * const kResultsArrayKey = @"results";
static NSString * const kArtwork100URLKey = @"artworkUrl100";
static NSString * const kAppStoreURLKey = @"trackViewUrl";
static NSString * const kTrackNameKey = @"trackName";
static NSString * const kBundleIDKey = @"bundleId";

static NSString * const iTunesLookupAPIURLFormat = @"http://itunes.apple.com/lookup?id=%@&entity=software";

@interface GTMoreAppsView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)initialSetup;

/**
 For each app in the _apps array it diplays the icon and name. To fit the screen width, if not enough apps are found, it creates
 placeholders with an empty app icon and no name.
 */
- (void)buildView;

/**
 Remove every app from the view.
 */
- (void)cleanView;

- (UILabel *)createAppNameLabel;
- (UIButton *)createAppIconButton;

- (NSArray *)parseLookUpDictionaryForApps:(NSDictionary *)dictionary fromCache:(BOOL)fromCache; // returns an array of GTApp objects.
- (void)openAppURL:(UIButton *)sender;
- (void)openApp:(UIButton *)sender;
- (NSString *)cacheFilePath;

@end

#pragma mark - Implementation

@implementation GTMoreAppsView

@synthesize apps = _apps;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize activityIndicator = _activityIndicator;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSetup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialSetup];
}

- (void)initialSetup
{
    [self addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
}

#pragma mark - Private APIs

- (void)buildView
{
    NSUInteger numberOfItemsInPage = floor([UIScreen mainScreen].bounds.size.width / (kItemsMargin + kItemsSize.width));
    NSUInteger numberOfPages = ceil((double)[self.apps count] / numberOfItemsInPage);
    self.pageControl.numberOfPages = numberOfPages;
    
    NSUInteger numberOfApps = [self.apps count];
    NSUInteger numberOfItemsToDisplay = numberOfPages * numberOfItemsInPage;
    CGFloat leftMargin = 20.0f;
    
    for (int i = 0; i < numberOfItemsToDisplay; i++) {
        if (i < numberOfApps) {
            GTApp *app = [self.apps objectAtIndex:i];
            
            UIButton *iconButton = [self createAppIconButton];
            iconButton.frame = (CGRect){leftMargin + ((kItemsMargin + kItemsSize.width) * i), kViewMargin, kItemsSize};
            [iconButton setBackgroundImage:app.icon forState:UIControlStateNormal];
            iconButton.backgroundColor = [UIColor clearColor];
            iconButton.tag = i;
            
            [self.scrollView addSubview:iconButton];
            
            if (![app isAppInstalledOnDevice]) {
                // Info Button View
                UIView *infoButtonView = [[UIView alloc] initWithFrame:iconButton.frame];
                infoButtonView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
                infoButtonView.layer.cornerRadius = 8.0f;
                
                [self.scrollView addSubview:infoButtonView];
                
                // Info Button
                UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
                [infoButton addTarget:self action:@selector(openAppURL:) forControlEvents:UIControlEventTouchUpInside];
                infoButton.backgroundColor = [UIColor clearColor];
                infoButton.center = iconButton.center;
                infoButton.tag = i;
                
                [self.scrollView addSubview:infoButton];
            }
            else {
                [iconButton addTarget:self action:@selector(openApp:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            CGRect labelFrame = CGRectMake(iconButton.frame.origin.x - kViewMargin, kViewMargin * 1.1f + kItemsSize.height, 
                                           kItemsSize.width + (kViewMargin * 2), 25.0f);
            UILabel *label = [self createAppNameLabel];
            label.frame = labelFrame;
            label.text = app.name;
            
            [self.scrollView addSubview:label];
        }
        else {
            UIButton *iconButton = [self createAppIconButton];
            iconButton.frame = (CGRect){leftMargin + ((kItemsMargin + kItemsSize.width) * i), kViewMargin, kItemsSize};
            [self.scrollView addSubview:iconButton];
        }
    }
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self.activityIndicator stopAnimating];
}

- (void)cleanView
{
    [self.scrollView removeFromSuperview], self.scrollView = nil;
    [self.pageControl removeFromSuperview], self.pageControl = nil;
}

- (UILabel *)createAppNameLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.font = [UIFont boldSystemFontOfSize:9];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.shadowOffset = (CGSize){0.0f, 0.5f};
    label.shadowColor = [UIColor whiteColor];
    label.numberOfLines = 2;
    
    return label;
}

- (UIButton *)createAppIconButton
{
    UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    iconButton.backgroundColor = [UIColor darkGrayColor];
    iconButton.layer.cornerRadius = 8.0f;
    
    return iconButton;
}

#pragma mark - Apps Loading

- (NSArray *)parseLookUpDictionaryForApps:(NSDictionary *)dictionary fromCache:(BOOL)fromCache
{
    NSMutableArray *parsedArray = [NSMutableArray array];
    NSArray *resultsArray = nil;
    
    if (dictionary) {
        resultsArray = [dictionary objectForKey:kResultsArrayKey];
        
        [resultsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx || fromCache) { // NOTE: is the dictionary is not loaded from the cache, the first results contains the artist's infos.
                NSDictionary *appDictionary = obj;
                NSString *appName = [appDictionary objectForKey:kTrackNameKey];
                NSString *bundleIdentifier = [appDictionary objectForKey:kBundleIDKey];
                NSString *appArtworkURLString = [appDictionary objectForKey:kArtwork100URLKey];
                NSURL *appStoreURL = [NSURL URLWithString:[appDictionary objectForKey:kAppStoreURLKey]];
                
                UIImage *appIcon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appArtworkURLString]]];
                if (!appIcon && [[NSFileManager defaultManager] fileExistsAtPath:appArtworkURLString]) {
                    appIcon = [UIImage imageWithData:[NSData dataWithContentsOfFile:appArtworkURLString]];
                }
                
                GTApp *app = [[GTApp alloc] init];
                app.bundleIdentifier = bundleIdentifier;
                app.appStoreURL = appStoreURL;
                app.icon = appIcon;
                app.name = appName;
                
                [parsedArray addObject:app];
            }
        }];
    }
    
    if (!fromCache && resultsArray) {
        NSMutableArray *cacheArray = [NSMutableArray arrayWithCapacity:[parsedArray count]];
        
        for (GTApp *app in parsedArray) {
            [cacheArray addObject:[app dictionaryForm]];
        }
        
        NSDictionary *cache = [NSDictionary dictionaryWithObject:cacheArray forKey:kResultsArrayKey];
        [cache writeToFile:[self cacheFilePath] atomically:YES];
    }
    
    return parsedArray;
}

- (void)openAppURL:(UIButton *)sender
{
    GTApp *app = [self.apps objectAtIndex:sender.tag];
    [app viewOnAppStore];
}

- (void)openApp:(UIButton *)sender
{
#warning ask the user first!
    GTApp *app = [self.apps objectAtIndex:sender.tag];
    [app open];
}

- (NSString *)cacheFilePath
{
    NSString *cacheDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cacheFilePathComponent = [NSString stringWithFormat:@"/%@/%@.plist", kCacheFolderName, kMoreAppsCacheFileName];
    NSString *cacheFilePath = [cacheDirectoryPath stringByAppendingPathComponent:cacheFilePathComponent];
    return cacheFilePath;
}

#pragma mark - Public APIs

- (void)lookupAppsWithDeveloperID:(NSString *)developerID completionBlock:(void (^)(NSArray *))completionBlock
{    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSError *error = nil;
        NSArray *results = nil;
        
        NSURL *iTunesLookupURL = [NSURL URLWithString:[NSString stringWithFormat:iTunesLookupAPIURLFormat, developerID]];
        NSData *data = [NSData dataWithContentsOfURL:iTunesLookupURL];
        if (data) {
            NSDictionary *appsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            results = [self parseLookUpDictionaryForApps:appsDictionary fromCache:NO];
            if (error) NSLog(@"Error: %@", error);
        }
        
        if (!data || error) {
            NSString *cachePath = [self cacheFilePath];
            if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
                results = [self parseLookUpDictionaryForApps:[NSDictionary dictionaryWithContentsOfFile:cachePath] fromCache:YES];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(results);
        });
    });
}

#pragma mark - Custom Setters and Getters

- (void)setApps:(NSArray *)apps {
    if (![_apps isEqualToArray:apps]) {
        if (_apps)[self cleanView];
        _apps = apps;
        [self buildView];
    }
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;
        
        self.scrollView = scrollView;
    }
    
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.frame = CGRectMake(0.0f, self.bounds.size.height - pageControl.bounds.size.height - kViewMargin, 
                                       self.bounds.size.width, pageControl.bounds.size.height);
        
        self.pageControl = pageControl;
    }
    
    return _pageControl;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        ai.center = (CGPoint){self.bounds.size.width / 2, self.bounds.size.height / 2};
        ai.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                               UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        ai.hidesWhenStopped = YES;
        
        self.activityIndicator = ai;
    }
    
    return _activityIndicator;
}

@end

/**
 @class GTApp implementation
 */

@implementation GTApp

@synthesize icon = _icon;
@synthesize name = _name;
@synthesize appStoreURL = _appStoreURL;
@synthesize bundleIdentifier = _bundleIdentifier;

- (void)open;
{
    NSString *appURLSchemeURLString = [NSString stringWithFormat:@"%@://", self.bundleIdentifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURLSchemeURLString]];
}

- (void)viewOnAppStore
{
    [[UIApplication sharedApplication] openURL:self.appStoreURL];
}

- (BOOL)isAppInstalledOnDevice
{
    NSString *appURLSchemeURLString = [NSString stringWithFormat:@"%@://", self.bundleIdentifier];
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appURLSchemeURLString]];
}

- (NSDictionary *)dictionaryForm
{
    if (self.icon) {
        NSError *error = nil;
        NSString *cacheDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *iconsDirectoryPath = [cacheDirectoryPath stringByAppendingFormat:@"/%@/Icons", kCacheFolderName];
        [[NSFileManager defaultManager] createDirectoryAtPath:iconsDirectoryPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        
        if (!error) {
            // save image on disk if it doesn't already exist. To avoid problems with names, use the bundleIdentifier as name image.
            NSString *appIconFilePath = [iconsDirectoryPath stringByAppendingFormat:@"/%@.png", self.bundleIdentifier];
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:appIconFilePath]) {
                NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(self.icon)];
                [[NSFileManager defaultManager] createFileAtPath:appIconFilePath contents:imageData attributes:nil];
            }
            
            return [NSDictionary dictionaryWithObjectsAndKeys:
                    self.name, kTrackNameKey,
                    appIconFilePath, kArtwork100URLKey,
                    [self.appStoreURL absoluteString], kAppStoreURLKey,
                    self.bundleIdentifier, kBundleIDKey, nil];
        }
    }
    
    return nil;
}

@end
