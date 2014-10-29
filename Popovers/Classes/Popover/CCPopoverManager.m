//
//  CCPopoverManager.m
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


#import "CCPopoverManager.h"


@implementation CCPopoverManager

- (void)setActivePopoverController:(id<CCPopoverViewController>)activePopoverController animated:(BOOL)animated
{
  if (activePopoverController != self.activePopoverController)
  {
    if ([self.activePopoverController isPopoverVisible])
    {
      [self.activePopoverController dismissPopoverAnimated:animated];
    }
  }
  
  self.activePopoverController = activePopoverController;
}

- (void)presentPopoverController:(id<CCPopoverViewController>)popoverController
                        fromRect:(CGRect)rect
                          inView:(UIView *)view
                        animated:(BOOL)animated
{
  [self setActivePopoverController:popoverController animated:animated];
  
  [self.activePopoverController presentPopoverFromRect:rect inView:view animated:animated];
}

- (void)presentPopoverController:(id<CCPopoverViewController>)popoverController
               fromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated
{
  [self setActivePopoverController:popoverController animated:animated];
  
  [self.activePopoverController presentPopoverFromBarButtonItem:item animated:animated];
}

- (BOOL)isPopoverVisible
{
  return [self.activePopoverController isPopoverVisible];
}

- (void)popoverWillRotate
{
  [self.activePopoverController dismissPopoverAnimated:YES];
}

- (void)popoverDidRotate
{
  if (self.activePopoverController.rotationBlock)
  {
    self.activePopoverController.rotationBlock(self.activePopoverController);
  }
}

- (void)popoverDidScroll
{
  if (self.activePopoverController.scrollBlock)
  {
    self.activePopoverController.scrollBlock(self.activePopoverController);
  }
}

- (void)dismissPopoverAnimated:(BOOL)animated
{
  [self.activePopoverController dismissPopoverAnimated:animated];
  
  self.activePopoverController = nil;
}

#pragma mark - CCSingleton implementations

+ (instancetype)sharedInstance
{
  static CCPopoverManager *instance;
  
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^
                {
                  instance = [[super allocWithZone:nil] init];
                });
  
  return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
	return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

@end
