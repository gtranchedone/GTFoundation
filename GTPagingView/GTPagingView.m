//
//  GTPagingView.m
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 11/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import "GTPagingView.h"

#define PageControlHeight 30

@interface GTPagingView () <UIScrollViewDelegate>

@property (nonatomic, assign) NSUInteger numberOfPages;
@property (nonatomic, strong) NSMutableArray *reusableViewsPool;

- (void)initialSetup;
- (void)setupPagingView;
- (void)loadPageAtIndex:(NSInteger)index;
- (void)changePageUsingPageControl:(UIPageControl *)pageControl;

@end

#pragma mark - Implementation

@implementation GTPagingView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize numberOfPages = _numberOfPages;
@synthesize reusableViewsPool = _reusableViewsPool;

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
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    self.backgroundColor = [UIColor blackColor];
}

- (void)setupPagingView
{
    // get the number of pages, prepare the reusable pool and resize the scrollView's contentSize
    self.numberOfPages = [self.dataSource numberOfPagesInPagingView:self];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * self.numberOfPages, self.scrollView.bounds.size.height);
    self.pageControl.numberOfPages = self.numberOfPages;
    
    // setup the pool of reusable views
    self.reusableViewsPool = [[NSMutableArray alloc] initWithCapacity:self.numberOfPages];
    for (int i = 0; i < _numberOfPages; i++) {
        [self.reusableViewsPool addObject:[NSNull null]];
    }
    
    // load the first two pages
    [self loadPageAtIndex:0];
    [self loadPageAtIndex:1];
}

#pragma mark - Pagination Logic

- (void)loadPageAtIndex:(NSInteger)index
{
    // if the index is out of bounds do nothing
    if (index >= self.numberOfPages || index < 0) {
        return;
    }
    
    // load the page
    UIView *view = [self.reusableViewsPool objectAtIndex:index];
    if ([(NSNull *)view isEqual:[NSNull null]]) {
        view = [self.dataSource viewForPageAtIndex:index inPagingView:self];
        view.frame = (CGRect){self.scrollView.bounds.size.width * index, 0.0, self.scrollView.bounds.size};
        [self.reusableViewsPool replaceObjectAtIndex:index withObject:view];
    }
    
    if (![view isDescendantOfView:self.scrollView]) {
        [self.scrollView addSubview:view];
    }
}

- (void)changePageUsingPageControl:(UIPageControl *)pageControl
{
    [self loadPageAtIndex:pageControl.currentPage + 1];
    [self.scrollView setContentOffset:CGPointMake((self.scrollView.bounds.size.width * pageControl.currentPage), self.scrollView.contentOffset.y) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    [self loadPageAtIndex:self.pageControl.currentPage + 1]; // when going backwards all the pages are already loaded
}

#pragma mark - Custom Setters and Getters

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        CGRect frame = (CGRect){CGPointZero, self.bounds.size.width, self.bounds.size.height - PageControlHeight};
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
        _scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        CGRect frame = (CGRect){0.0, self.bounds.size.height - PageControlHeight, self.bounds.size.width, PageControlHeight};
        _pageControl = [[UIPageControl alloc] initWithFrame:frame];
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_pageControl addTarget:self action:@selector(changePageUsingPageControl:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _pageControl;
}

- (void)setDataSource:(id<GTPagingViewDataSource>)dataSource
{
    _dataSource = dataSource;
    
    [self setupPagingView];
}

@end
