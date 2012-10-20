//
//  GTGuideViewController.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 06/12/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTGuideViewController.h"

NSString * const GTGuideViewTitleKey = @"GTGuideViewTitleKey";
NSString * const GTGuideViewImageKey = @"GTGuideViewImageKey";
NSString * const GTGuideViewTextKey = @"GTGuideViewTextKey";

static CGRect const kTitleLabelFrame = (CGRect){10.0f, 30.0f, 300.0f, 50.0f};
static CGRect const kTextLabelFrame = (CGRect){10.0f, 250.0f, 300.0f, 100.0f};
static CGRect const kImageViewFrame = (CGRect){10.0f, 100.0f, 300.0f, 130.0f};

@interface GTGuideViewController () <UIScrollViewDelegate>
{
    CGFloat oldScrollViewOffsetX;
    BOOL scrolling;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tempTextLabel;
@property (nonatomic, strong) UILabel *tempTitleLabel;

- (void)changePage:(UIBarButtonItem *)sender;
- (void)removeGuide:(UIBarButtonItem *)sender;
- (NSDictionary *)pageAtIndex:(NSInteger)index;
- (void)didMoveFromPage:(NSUInteger)fromPage toPage:(NSUInteger)toPage scrollingLeft:(BOOL)scrollingLeft;

@end

#pragma mark - Implementation

@implementation GTGuideViewController

@synthesize delegate = delegate_;

@synthesize scrollView = scrollView_;
@synthesize pageControl = pageControl_;

@synthesize textLabel = textLabel_;
@synthesize titleLabel = titleLabel_;
@synthesize tempTextLabel = tempTextLabel_;
@synthesize tempTitleLabel = tempTitleLabel_;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Navigation Bar
    UIBarButtonItem *nextPageButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil) 
                                                                       style:UIBarButtonItemStyleBordered 
                                                                      target:self 
                                                                      action:@selector(changePage:)];
    nextPageButton.tintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = nextPageButton;
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    // Background
    CAGradientLayer *backgroundLayer = [CAGradientLayer layer];
    backgroundLayer.frame = self.view.bounds;
    backgroundLayer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor lightGrayColor].CGColor, nil];
    [self.view.layer addSublayer:backgroundLayer];
    
    if (self.delegate) {
        [self.view addSubview:self.scrollView];
        [self.view addSubview:self.titleLabel];
        [self.view addSubview:self.textLabel];
        [self.view addSubview:self.tempTextLabel];
        [self.view addSubview:self.tempTitleLabel];
        
        self.tempTextLabel.alpha = 0;
        self.tempTitleLabel.alpha = 0;
        
        // Page Control
        NSUInteger numberOfPages = [self.delegate numberOfPagesInGuide:self];
        if (numberOfPages == 0) {
            numberOfPages = 1;
        }
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:(CGRect){CGPointZero, self.view.bounds.size.width, 20}];
        self.pageControl.center = CGPointMake(self.view.center.x, 
                                              self.view.bounds.size.height - self.pageControl.bounds.size.height - 60);
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        self.pageControl.backgroundColor = [UIColor clearColor];
        self.pageControl.numberOfPages = numberOfPages;
        self.pageControl.hidesForSinglePage = YES;
        [self.view addSubview:self.pageControl];
        
        // Scroll View Content Size Setup
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.pageControl.numberOfPages, 
                                                 self.view.bounds.size.height);
        
        // First Two Pages Setup and all Images
        self.titleLabel.text = [[self pageAtIndex:0] objectForKey:GTGuideViewTitleKey];
        self.textLabel.text = [[self pageAtIndex:0] objectForKey:GTGuideViewTextKey];
        
        self.tempTitleLabel.text = [[self pageAtIndex:1] objectForKey:GTGuideViewTitleKey];
        self.tempTextLabel.text = [[self pageAtIndex:1] objectForKey:GTGuideViewTextKey];
        
        for (int i = 0; i < self.pageControl.numberOfPages; i++) {
            UIImage *image = [[self pageAtIndex:i] objectForKey:GTGuideViewImageKey];
            UIImageView *view = [[UIImageView alloc] initWithImage:image];
            view.layer.contentsGravity = kCAGravityResizeAspect;
            view.frame = (CGRect){kImageViewFrame.origin.x + (self.view.bounds.size.width * i), kImageViewFrame.origin.y, kImageViewFrame.size};
            [self.scrollView addSubview:view];
        }
    }
}

#pragma mark - Private Methods

- (void)changePage:(UIBarButtonItem *)sender
{
    // Fix for UI interaction
    sender.enabled = NO;
    
    // If this method is called from the navigationButton change the value of the current page
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        self.pageControl.currentPage++;
    }
    
    // Change Page
    CGRect rect = (CGRect){self.view.bounds.size.width * self.pageControl.currentPage, 0.0, self.view.bounds.size};
    [self.scrollView scrollRectToVisible:rect animated:YES];
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:self.scrollView afterDelay:0.3];
    
    if ([self.delegate respondsToSelector:@selector(guide:didMoveToPageAtIndex:)]) {
        [self.delegate guide:self didMoveToPageAtIndex:self.pageControl.currentPage];
    }
}

- (void)removeGuide:(UIBarButtonItem *)sender
{
    // If the current page is the last one, dismiss the guide, otherwhise move to the next page by calling the 'changePage:' method
    if (self.pageControl.currentPage == (self.pageControl.numberOfPages - 1)) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
        sender.enabled = NO;
    } 
    else {
        // the 'changePage:' method will handle the change of the button's action and move to the next page
        [self changePage:sender];
    }
}

- (NSDictionary *)pageAtIndex:(NSInteger)index
{
    NSDictionary *data = [self.delegate guide:self detailsForViewAtIndex:index];
    return data;
}

- (void)didMoveFromPage:(NSUInteger)fromPage toPage:(NSUInteger)toPage scrollingLeft:(BOOL)scrollingLeft
{
    // if the two pages are the same restore previous values
    if (fromPage == toPage) {
        if (scrollingLeft) {
            self.textLabel.alpha = 1;
            self.titleLabel.alpha = 1;
            self.tempTextLabel.alpha = 0;
            self.tempTitleLabel.alpha = 0;
        }
        else {
            self.tempTitleLabel.alpha = 1;
            self.tempTextLabel.alpha = 1;
            self.titleLabel.alpha = 0;
            self.textLabel.alpha = 0;
        }
    }
    
    NSDictionary *delegateDate = [self pageAtIndex:toPage];
    self.textLabel.text = [delegateDate objectForKey:GTGuideViewTextKey];
    self.titleLabel.text = [delegateDate objectForKey:GTGuideViewTitleKey];
    self.tempTextLabel.text = [delegateDate objectForKey:GTGuideViewTextKey];
    self.tempTitleLabel.text = [delegateDate objectForKey:GTGuideViewTitleKey];
    
    // set the new page
    self.pageControl.currentPage = toPage;
    scrolling = NO;
    
    // Change the next button's title and action if needed
    if (toPage == (self.pageControl.numberOfPages - 1)) {
        [self.navigationItem.rightBarButtonItem setAction:@selector(removeGuide:)];
        [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Finish", nil)];
    } else {
        [self.navigationItem.rightBarButtonItem setAction:@selector(changePage:)];
        [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Next", nil)];
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    NSUInteger page = scrollView.contentOffset.x / self.view.bounds.size.width;
    BOOL scrollingLeft = (page > self.pageControl.currentPage);
    
    // Set New Page
    if (page != self.pageControl.currentPage) {
        if ([self.delegate respondsToSelector:@selector(guide:didMoveToPageAtIndex:)]) {
            [self.delegate guide:self didMoveToPageAtIndex:page];
        }
    }

    [self didMoveFromPage:self.pageControl.currentPage toPage:page scrollingLeft:scrollingLeft];
}

- (void)didScroll:(BOOL)scrollDirectionLeft;
{
    if (!scrolling) {
        // set the next/previous page text
        NSInteger page = self.scrollView.contentOffset.x / self.view.bounds.size.width;
        
        if (scrollDirectionLeft) { // next page
            if ((page + 1) > (self.pageControl.numberOfPages - 1)) {
                page--;
            }
            
            self.tempTitleLabel.text = [[self pageAtIndex:page+1] objectForKey:GTGuideViewTitleKey];
            self.tempTextLabel.text = [[self pageAtIndex:page+1] objectForKey:GTGuideViewTextKey];
        } 
        else { // previous page
            self.titleLabel.text = [[self pageAtIndex:page] objectForKey:GTGuideViewTitleKey];
            self.textLabel.text = [[self pageAtIndex:page] objectForKey:GTGuideViewTextKey];
        }
        
        scrolling = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BOOL scrollDirectionLeft = (oldScrollViewOffsetX < scrollView.contentOffset.x); // is moving through the next page
    oldScrollViewOffsetX = scrollView.contentOffset.x;
    
    CGFloat pageMultiplier = (self.pageControl.currentPage * self.view.bounds.size.width);
    CGFloat showAlpha = (scrollView.contentOffset.x - pageMultiplier) / self.view.bounds.size.width;
    CGFloat hideAlpha = 1 - showAlpha; // it's the opposite of 'hideAlpha'
    
    // If the scroll direction is right (so the user is moving through the previous page) the alpha values must be adjusted as follow
    if (!scrollDirectionLeft) {
        showAlpha = -showAlpha;
        hideAlpha = 1 - showAlpha;
    }
        
    if (scrollDirectionLeft) {
        self.titleLabel.alpha = hideAlpha;
        self.tempTitleLabel.alpha = showAlpha;
        
        self.textLabel.alpha = hideAlpha;
        self.tempTextLabel.alpha = showAlpha;
    }
    else {
        self.titleLabel.alpha = showAlpha;
        self.tempTitleLabel.alpha = hideAlpha;
        
        self.textLabel.alpha = showAlpha;
        self.tempTextLabel.alpha = hideAlpha;
    }
    
    [self didScroll:scrollDirectionLeft];
}

#pragma mark - Setters and Getters

- (UILabel *)titleLabel
{
    if (!titleLabel_) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:kTitleLabelFrame];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.font = [UIFont boldSystemFontOfSize:19];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        titleLabel.shadowColor = [UIColor whiteColor];
        titleLabel.numberOfLines = 2;
        
        self.titleLabel = titleLabel;
    }
    
    return titleLabel_;
}

- (UILabel *)textLabel
{
    if (!textLabel_) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:kTextLabelFrame];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        textLabel.shadowColor = [UIColor whiteColor];
        textLabel.numberOfLines = 0;
        
        self.textLabel = textLabel;
    }
    
    return textLabel_;
}

- (UILabel *)tempTitleLabel
{
    if (!tempTitleLabel_) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:kTitleLabelFrame];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.font = [UIFont boldSystemFontOfSize:19];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        titleLabel.shadowColor = [UIColor whiteColor];
        titleLabel.numberOfLines = 2;
        
        self.tempTitleLabel = titleLabel;
    }
    
    return tempTitleLabel_;
}

- (UILabel *)tempTextLabel
{
    if (!tempTextLabel_) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:kTextLabelFrame];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        textLabel.shadowColor = [UIColor whiteColor];
        textLabel.numberOfLines = 0;
        
        self.tempTextLabel = textLabel;
    }
    
    return tempTextLabel_;
}

- (UIScrollView *)scrollView
{
    if (!scrollView_) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        
        self.scrollView = scrollView;
    }
    
    return scrollView_;
}

@end
