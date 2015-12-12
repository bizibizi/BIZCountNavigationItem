//
//  BIZCountNavigationItem.h
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 6/15/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import <UIKit/UIKit.h>


//! UIBarButtonItem with count, changes animated
@interface BIZCountNavigationItem : UIBarButtonItem

//! Designative initializer
- (instancetype)initWithTarget:(id)target action:(SEL)action;
//! Change count animated
@property (nonatomic) NSInteger count;

@property (nonatomic, strong) UILabel *badgeLabel;

//Measurements
@property (nonatomic) NSInteger padding;
@property (nonatomic) NSInteger badgeLabelOriginX;
@property (nonatomic) NSInteger badgeLabelOriginY;

@end
