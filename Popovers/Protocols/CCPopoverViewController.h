//
//  CCPopoverViewController.h
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


@protocol CCPopoverViewController <NSObject>

- (BOOL)isPopoverVisible;

- (void)dismissPopoverAnimated:(BOOL)animated;

@optional

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;

- (void)addPassthroughView:(UIView *)passthroughView;

- (void)removePassthroughView:(UIView *)passthroughView;

@property (copy, nonatomic) void (^rotationBlock)(id<CCPopoverViewController> popoverController);

@property (copy, nonatomic) void (^scrollBlock)(id<CCPopoverViewController> popoverController);

@end
