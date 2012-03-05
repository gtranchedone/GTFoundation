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

#define ImageViewLeftMargin 30
#define ImageViewTopMargin 100
#define ImageViewHeight 150
#define LabelsLeftMargin 20
#define LabelsTopMargin 20
#define TitleLabelHeight 30

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

- (void)changePage:(id)sender;
- (NSDictionary *)pageAtIndex:(NSInteger)index;
- (void)didMoveFromPage:(NSUInteger)fromPage toPage:(NSUInteger)toPage scrollingLeft:(BOOL)scrollingLeft;

- (void)removeGuide:(id)sender;

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


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Navigation Bar
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor blackColor], UITextAttributeTextColor,
                                    [UIColor whiteColor], UITextAttributeTextShadowColor,
                                    CGSizeMake(0.0, -1.0), UITextAttributeTextShadowOffset, nil];
    UIBarButtonItem *nextPageButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(changePage:)];
    nextPageButton.tintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    [nextPageButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = nextPageButton;
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    // Background
    CAGradientLayer *backgroundLayer = [CAGradientLayer layer];
    backgroundLayer.frame = self.view.bounds;
    backgroundLayer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor lightGrayColor].CGColor, nil];
    [self.view.layer addSublayer:backgroundLayer];
    
    if (self.delegate) {
        // Title Label        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LabelsLeftMargin, (LabelsTopMargin * 2), 
                                                self.view.bounds.size.width - (LabelsLeftMargin * 2), TitleLabelHeight)]; 
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        self.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        self.titleLabel.shadowColor = [UIColor whiteColor];
        [self.view addSubview:self.titleLabel];
        
        // Text Label
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textAlignment = UITextAlignmentCenter;
        self.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        self.textLabel.shadowColor = [UIColor whiteColor];
        self.textLabel.numberOfLines = 0;
        [self.view addSubview:self.textLabel];
        
        // Temp Labels
        self.tempTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.tempTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.tempTextLabel.backgroundColor = [UIColor clearColor];
        self.tempTextLabel.textAlignment = UITextAlignmentCenter;
        self.tempTextLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        self.tempTextLabel.shadowColor = [UIColor whiteColor];
        self.tempTextLabel.numberOfLines = 0;
        
        self.tempTitleLabel = [[UILabel alloc] initWithFrame:self.titleLabel.frame]; 
        self.tempTitleLabel.font = [UIFont boldSystemFontOfSize:19];
        self.tempTitleLabel.backgroundColor = [UIColor clearColor];
        self.tempTitleLabel.textAlignment = UITextAlignmentCenter;
        self.tempTitleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        self.tempTitleLabel.shadowColor = [UIColor whiteColor];
        
        self.tempTextLabel.alpha = 0;
        self.tempTitleLabel.alpha = 0;
        
        [self.view addSubview:self.tempTextLabel];
        [self.view addSubview:self.tempTitleLabel];
        
        // ScrollView
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self.view addSubview:self.scrollView];
        
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
        
        // First Two Pages Setup
        self.titleLabel.text = [[self pageAtIndex:0] objectForKey:GTGuideViewTitleKey];
        self.textLabel.text = [[self pageAtIndex:0] objectForKey:GTGuideViewTextKey];
        
        self.tempTitleLabel.text = [[self pageAtIndex:1] objectForKey:GTGuideViewTitleKey];
        self.tempTextLabel.text = [[self pageAtIndex:1] objectForKey:GTGuideViewTextKey];
        
        CGSize size = CGSizeMake(self.view.bounds.size.width - (LabelsLeftMargin * 2), 
                                 self.view.bounds.size.height - ImageViewTopMargin - ImageViewHeight - LabelsTopMargin);
        CGSize textSize = [self.tempTextLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:19] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        self.textLabel.frame = CGRectMake(LabelsLeftMargin, ImageViewTopMargin + ImageViewHeight, 
                                          self.view.bounds.size.width - (LabelsLeftMargin * 2), textSize.height);
        self.tempTextLabel.frame = self.textLabel.frame;
        
        // TODO: change this
        int index = 1;
        while (index <= 5 && index <= self.pageControl.numberOfPages) {
            
            UIImage *image = [[self pageAtIndex:index] objectForKey:GTGuideViewImageKey];
            UIImageView *view = [[UIImageView alloc] initWithImage:image];
            view.frame = (CGRect){self.view.bounds.size.width * (index - 1), ImageViewTopMargin, view.bounds.size};
            view.center = CGPointMake(self.view.center.x + (self.view.bounds.size.width * (index - 1)), view.center.y);
            view.layer.contentsGravity = kCAGravityResizeAspect;
            
            [self.scrollView addSubview:view];
            
            index++;
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - Private Methods

- (void)changePage:(id)sender
{
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

- (void)removeGuide:(id)sender
{
    // If the current page is the last one, dismiss the guide, otherwhise move to the next page by calling the 'changePage:' method
    if (self.pageControl.currentPage == (self.pageControl.numberOfPages - 1)) {
        [self.presentingViewController dismissModalViewControllerAnimated:YES];
    } 
    else {
        // the 'changePage:' method will handle the change of the button's action and move to the next page
        [self changePage:sender];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
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
        
        CGSize size = CGSizeMake(self.view.bounds.size.width - (LabelsLeftMargin * 2), 
                                 self.view.bounds.size.height - ImageViewTopMargin - ImageViewHeight - LabelsTopMargin);
        
        if (scrollDirectionLeft) { // next page
            if ((page + 1) > (self.pageControl.numberOfPages - 1)) {
                page--;
            }
            
            self.tempTitleLabel.text = [[self pageAtIndex:page+1] objectForKey:GTGuideViewTitleKey];
            
            NSString *text = [[self pageAtIndex:page+1] objectForKey:GTGuideViewTextKey];
            CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:19] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            self.tempTextLabel.frame = CGRectMake(LabelsLeftMargin, ImageViewTopMargin + ImageViewHeight, 
                                                  self.view.bounds.size.width - (LabelsLeftMargin * 2), textSize.height);
            self.tempTextLabel.text = text;
            self.textLabel.frame = self.tempTextLabel.frame;
        } 
        else { // previous page
            self.titleLabel.text = [[self pageAtIndex:page] objectForKey:GTGuideViewTitleKey];
            
            NSString *text = [[self pageAtIndex:page] objectForKey:GTGuideViewTextKey];
            CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:19] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            self.textLabel.frame = CGRectMake(LabelsLeftMargin, ImageViewTopMargin + ImageViewHeight, 
                                                  self.view.bounds.size.width - (LabelsLeftMargin * 2), textSize.height);
            self.textLabel.text = text;
            self.tempTextLabel.frame = self.textLabel.frame;
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

@end
