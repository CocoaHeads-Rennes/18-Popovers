//
//  CCPopoverCell.m
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


#import "CCPopoverCell.h"


@implementation CCPopoverCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  
  if (self)
  {
    [self prepareForReuse];
  }
  
  return self;
}

- (void)prepareForReuse
{
  self.textLabel.text = nil;
}

#pragma mark - CCTableViewCell implementations

+ (NSString *)reuseIdentifier
{
  return @"Popover Cell";
}

+ (CGFloat)cellHeight
{
  return 44.0;
}

+ (void)registerWithTableView:(UITableView *)tableView
{
  UINib *cellNib = [UINib nibWithNibName:@"CCPopoverCell" bundle:nil];
  
  [tableView registerNib:cellNib forCellReuseIdentifier:[self reuseIdentifier]];
}

@end
