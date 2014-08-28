//
//  BookControllerViewController.m
//  TestBedViewController
//
//  Created by Cruise on 14-7-9.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import "BookControllerViewController.h"

#define IS_IPHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define SAFE_ADD(_Array_, _Object_) {if (_Object_ && [_Array_ isKindOfClass:[NSMutableArray class]]) [pageControllers addObject:_Object_];}
#define SAFE_PERFORM_WITH_ARG(THE_OBJECT, THE_SELECTOR, THE_ARG) (([THE_OBJECT respondsToSelector:THE_SELECTOR]) ? [THE_OBJECT performSelector:THE_SELECTOR withObject:THE_ARG] : nil)


@interface BookControllerViewController ()  <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@end

@implementation BookControllerViewController
@synthesize pageNumber = _pageNumber;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //[self.view addSubview:pageControl];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


+ (id) bookWithDelegate: (id) theDelegate style: (BookLayoutStyle) aStyle
{
    // Determine orientation
    UIPageViewControllerNavigationOrientation orientation = UIPageViewControllerNavigationOrientationHorizontal;
    if ((aStyle == BookLayoutStyleFlipBook) || (aStyle == BookLayoutStyleVerticalScroll))
        orientation = UIPageViewControllerNavigationOrientationVertical;
    
    // Determine transitionStyle
    UIPageViewControllerTransitionStyle transitionStyle = UIPageViewControllerTransitionStyleScroll;
    if ((aStyle == BookLayoutStyleHorizontalScroll) || (aStyle == BookLayoutStyleVerticalScroll))
        transitionStyle = UIPageViewControllerTransitionStyleScroll;
    
    // Pass options as a dictionary. Keys are spine location (curl) and spacing (scroll)
    BookControllerViewController *bc = [[BookControllerViewController alloc] initWithTransitionStyle:transitionStyle navigationOrientation:orientation options:nil];
    
    bc.layoutStyle = aStyle;
    bc.dataSource = bc;
    bc.delegate = bc;
    bc.bookDelegate = theDelegate;
    
    return bc;
}

+ (id) bookWithDelegate: (id) theDelegate
{
    return [self bookWithDelegate:theDelegate style:BookLayoutStyleBook];
}


- (BOOL) useSideBySide: (UIInterfaceOrientation) orientation
{
    BOOL isLandscape = UIInterfaceOrientationIsLandscape(orientation);
    
    switch (_layoutStyle)
    {
        case BookLayoutStyleHorizontalScroll:
        case BookLayoutStyleVerticalScroll: return NO;
        case BookLayoutStyleFlipBook: return !isLandscape;
        default: return isLandscape;
    }
}

- (UIViewController *) controllerAtPage: (int) aPageNumber
{
    if ([self.bookDelegate respondsToSelector:@selector(viewControllerForPage:)])
    {
        UIViewController *controller = [self.bookDelegate viewControllerForPage:aPageNumber];
        controller.view.tag = aPageNumber;                     //这个view好像不会释放
        return controller;
    }
    return nil;
}

- (void) fetchControllersForPage: (uint) requestedPage orientation: (UIInterfaceOrientation) orientation
{
    
    // Update the controllers
    NSMutableArray *pageControllers = [NSMutableArray array];
    SAFE_ADD(pageControllers, [self controllerAtPage:0]);
    
    [self setViewControllers:pageControllers direction: nil animated:YES completion:nil];
}

- (void) moveToPage: (uint) requestedPage
{
    [self fetchControllersForPage:requestedPage orientation:(UIInterfaceOrientation)self.interfaceOrientation];
}


- (UIViewController *)pageViewController:(UIPageViewController *)BookControllerViewController viewControllerAfterViewController:(UIViewController *)viewController       //viewController是当前的，该方法返回viewController的后一个vc（往后翻调用这个方法）
{
    return [self controllerAtPage:(viewController.view.tag+1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)BookControllerViewController viewControllerBeforeViewController:(UIViewController *)viewController       //viewController是当前的，该方法返回viewController的前一个vc（往前翻调用这个方法）
{
    return [self controllerAtPage:(viewController.view.tag-1)];   //viewController是当前的，即将离开的ViewController
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    NSUInteger indexOfCurrentViewController = 0;
    if (self.viewControllers.count)
        indexOfCurrentViewController = ((UIViewController *)[self.viewControllers objectAtIndex:0]).view.tag;
    [self fetchControllersForPage:indexOfCurrentViewController orientation:orientation];
    
    BOOL sideBySide = [self useSideBySide:orientation];
    UIPageViewControllerSpineLocation spineLocation = sideBySide ? UIPageViewControllerSpineLocationMid : UIPageViewControllerSpineLocationMin;
    self.doubleSided = sideBySide;
    return spineLocation;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        UIViewController* tmp = [self.viewControllers objectAtIndex:0];
        int a = tmp.view.tag;
        [self.bookDelegate setpageControl:a];
    }

}

@end






















