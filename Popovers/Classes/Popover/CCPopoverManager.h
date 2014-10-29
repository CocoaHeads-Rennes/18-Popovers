//
//  CCPopoverManager.h
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


#import "CCSingleton.h"
#import "CCPopoverViewController.h"


@interface CCPopoverManager : NSObject <CCSingleton>

- (void)presentPopoverController:(id<CCPopoverViewController>)popoverController
                        fromRect:(CGRect)rect
                          inView:(UIView *)view
                        animated:(BOOL)animated;

- (void)presentPopoverController:(id<CCPopoverViewController>)popoverController
               fromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;

@property (weak, nonatomic) id<CCPopoverViewController> activePopoverController;

- (BOOL)isPopoverVisible;

- (void)popoverWillRotate;

- (void)popoverDidRotate;

- (void)popoverDidScroll;

- (void)dismissPopoverAnimated:(BOOL)animated;

@end
