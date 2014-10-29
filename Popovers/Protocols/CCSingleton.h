//
//  CCSingleton.h
//  Popovers
//
//  Created by Joanna Carter on 10/08/2014.
//  Copyright (c) 2014 Carter Consulting. All rights reserved.
//


@protocol CCSingleton <NSObject>

+ (instancetype)sharedInstance;

+ (id)allocWithZone:(NSZone *)zone;

- (id)copyWithZone:(NSZone *)zone;

@end
