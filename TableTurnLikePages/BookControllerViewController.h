//
//  BookControllerViewController.h
//  TestBedViewController
//
//  Created by Cruise on 14-7-9.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULTS_BOOKPAGE   @"BookControllerMostRecentPage"

typedef enum
{
    BookLayoutStyleBook, // side by side in landscape
    BookLayoutStyleFlipBook, // side by side in portrait
    BookLayoutStyleHorizontalScroll,
    BookLayoutStyleVerticalScroll,
} BookLayoutStyle;

@class BookControllerViewController;

@protocol BookControllerDelegate <NSObject>
- (id) viewControllerForPage: (int) pageNumber;
- (void) setpageControl: (int) currentVC;
@end

@interface BookControllerViewController : UIPageViewController

+ (id) bookWithDelegate: (id) theDelegate;
+ (id) bookWithDelegate: (id) theDelegate style: (BookLayoutStyle) aStyle;
- (void) moveToPage: (uint) requestedPage;

@property (nonatomic, weak) id <BookControllerDelegate> bookDelegate;
@property (nonatomic) int pageNumber;          //viewController.view对应的页数
@property (nonatomic) BookLayoutStyle layoutStyle;

@end
