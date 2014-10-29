//
//  CCListCell.m
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


#import "CCListCell.h"


@implementation CCListCell

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
  
  self.detailTextLabel.text = nil;
}

- (CGRect)popoverOriginRect
{
  return self.detailTextLabel.frame;
}

#pragma mark - CCTableViewCell implementations

+ (NSString *)reuseIdentifier
{
  return @"List Cell";
}

+ (CGFloat)cellHeight
{
  return 44.0;
}

+ (void)registerWithTableView:(UITableView *)tableView
{
  UINib *cellNib = [UINib nibWithNibName:@"CCListCell" bundle:nil];
  
  [tableView registerNib:cellNib forCellReuseIdentifier:[self reuseIdentifier]];
}

@end
