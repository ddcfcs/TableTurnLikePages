//
//  TablePageViewController.m
//  TableTurnLikePages
//
//  Created by Cruise on 14-8-28.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import "TablePageViewController.h"
#import "BookControllerViewController.h"
#import "DDTableViewController.h"

@interface TablePageViewController ()
@property (nonatomic,strong) BookControllerViewController *bookController;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation TablePageViewController
@synthesize bookController = _bookController;
@synthesize pageControl = _pageControl;

#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define IS_IPAD	(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define RESIZABLE(_VIEW_) [_VIEW_ setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth]


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 40.0f)];
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    //self.pageControl.currentPage = 0;                     放在viewWillAppear里才有用
    self.pageControl.numberOfPages = 3;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.frame = (CGRect){0, 35, CGRectGetWidth(self.view.bounds), 0};
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.490 alpha:1.000];
    
    [self.view addSubview:self.pageControl];
}

- (void) viewWillAppear:(BOOL)animated
{
    if (!self.bookController)
    {
        self.bookController = [BookControllerViewController bookWithDelegate:self style:BookLayoutStyleHorizontalScroll];
    }
    self.bookController.view.frame = self.view.bounds;
    
    [self addChildViewController:self.bookController];
    [self.view addSubview:self.bookController.view];
    [self.view bringSubviewToFront:self.pageControl];               //很关键，否则bookController会遮挡住pageControlr
    //[bookController didMoveToParentViewController:self];
    
    [self.bookController moveToPage:0];                             //开始的bookController的controller.view.tag=0
    self.pageControl.currentPage = 0;
}

- (void)pageControlGesture:(UISwipeGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded))
    {
        self.currentPage += 1;
        self.currentPage -= 1;
    }
}


- (id) viewControllerForPage: (int) pageNumber
{
    //    self.pageControl.currentPage = pageNumber;  //必须放在 return nil 之前
    [self.view bringSubviewToFront:self.pageControl];
    
    if ((pageNumber < 0) || (pageNumber > 2)) return nil;           //控制只输出3个page

    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DDTableViewController *tableViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"DDTVC"];
    UISwipeGestureRecognizer *leftswiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(pageControlGesture:)];
    leftswiper.direction = UISwipeGestureRecognizerDirectionLeft;
    leftswiper.numberOfTouchesRequired = 1;
    [tableViewController.view addGestureRecognizer:leftswiper];
    
    UISwipeGestureRecognizer *rightswiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(pageControlGesture:)];
    rightswiper.direction = UISwipeGestureRecognizerDirectionLeft;
    rightswiper.numberOfTouchesRequired = 1;
    [tableViewController.view addGestureRecognizer:rightswiper];
    
    return tableViewController;
}

- (void)setpageControl:(int)currentVC
{
    self.pageControl.currentPage = currentVC;
}





@end
