//
//  CCTableViewCell.h
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


@protocol CCTableViewCell <NSObject>

+ (NSString *)reuseIdentifier;

+ (CGFloat)cellHeight;

+ (void)registerWithTableView:(UITableView *)tableView;

@end
