//
//  CCPopoverSelectionViewController.h
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


#import "CCPopoverViewController.h"


@interface CCPopoverSelectionViewController : UITableViewController <CCPopoverViewController>

- (instancetype)initWithWidth:(CGFloat)width permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

- (instancetype)initWithValues:(NSArray *)values width:(CGFloat)width permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

- (void)setSelectedValue:(NSString *)selectedValue;

@property (copy, nonatomic) void(^selectionBlock)(id value);

@end
