//
//  BIZCountNavigationItem.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 6/15/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZCountNavigationItem.h"
#import <QuartzCore/QuartzCore.h>


#define k_DURATION_badgeChangeFrame 0.5
static NSString * const kBounceAnimationKey = @"bounceAnimation";


@interface BIZCountNavigationItem ()
@property (nonatomic) BOOL changingValueInProgress;
@end


@implementation BIZCountNavigationItem


#pragma mark - LifeCycle


- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    //Default values
    self.padding = 8;
    self.badgeLabelOriginY = -4;
    
    // * Create Button as custom View to UIBarButtonItem, add right label with count
    UIButton *backButton = [[UIButton alloc]initWithFrame:self.badgeLabel.frame];
    [backButton addSubview:self.badgeLabel];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    self = [self initWithCustomView:backButton];
    self.target = target;
    self.action = action;
    
    if (!self) {
        return nil;
    }
    
    return self;
}

// * Create label
- (UILabel *)badgeLabel
{
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc]init];
        _badgeLabel.layer.frame = CGRectMake(self.badgeLabelOriginX, self.badgeLabelOriginY, 20, 20);
        _badgeLabel.hidden = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        [self.customView addSubview:_badgeLabel];
    }
    return _badgeLabel;
}


#pragma mark - Events


- (void)setCount:(NSInteger)count
{
    _count = count;
    
    if (_count <= 0) {
        _count = 0;
        [self hideBagdeLabel];
        
    } else {
        
        self.changingValueInProgress = YES;
        
        // * Pulse animation of change count
        CABasicAnimation *badgeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        badgeAnimation.fromValue = @(1.5);
        badgeAnimation.toValue = @(1.0);
        badgeAnimation.duration = k_DURATION_badgeChangeFrame;
        badgeAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:.4 :1.3 :1 :1];
        [self.badgeLabel.layer addAnimation:badgeAnimation forKey:kBounceAnimationKey];
        
        if (self.badgeLabel.layer.hidden) {
            self.badgeLabel.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }
        
        [UIView animateWithDuration:k_DURATION_badgeChangeFrame/4
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut |
                                UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             
                             [self showBagdeLabel];
                             self.badgeLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
                             [self updateBadgeFrame];
                             
                         } completion:^(BOOL finished) {
                             self.changingValueInProgress = NO;
                         }];
    }
}

// * Hide if count 0
- (void)hideBagdeLabel
{
    [self.badgeLabel.layer removeAnimationForKey:kBounceAnimationKey];

    [UIView animateWithDuration:self.changingValueInProgress ? 0 : k_DURATION_badgeChangeFrame
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         self.badgeLabel.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
                     } completion:^(BOOL finished) {
                         self.badgeLabel.layer.hidden = YES;
                     }];
}

- (void)showBagdeLabel
{
    if (self.badgeLabel.layer.hidden) {
        self.badgeLabel.layer.hidden = NO;
        self.badgeLabel.transform = CGAffineTransformIdentity;
    }
}

//! Change size of BadgeLabel base on its content size
- (void)updateBadgeFrame
{
    CGSize badgeLabelNewSize = [self.badgeLabel.text sizeWithAttributes:@{NSFontAttributeName : self.badgeLabel.font}];
    // * Fixed H of circle
    CGFloat h = badgeLabelNewSize.height + self.padding;
    CGFloat w = MAX(badgeLabelNewSize.width + self.padding, badgeLabelNewSize.height + self.padding);
    
    self.badgeLabel.layer.frame = CGRectMake(self.badgeLabelOriginX, self.badgeLabelOriginY, w, h);
    self.badgeLabel.layer.cornerRadius = h/2;
    self.badgeLabel.layer.masksToBounds = YES;
}


@end
