//
//  CCListCell.h
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


#import "CCTableViewCell.h"


@interface CCListCell : UITableViewCell <CCTableViewCell>

@property (nonatomic) CGRect popoverOriginRect;

@end
