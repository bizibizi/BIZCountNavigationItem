//
//  ViewController.m
//  ExampleBIZCountNavigationItem
//
//  Created by IgorBizi@mail.ru on 12/12/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "ViewController.h"
#import "BIZCountNavigationItem.h"


@interface ViewController ()
@property (nonatomic, strong) BIZCountNavigationItem *countNavigationItem;
@property (nonatomic) NSInteger count;
@end


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setup item
    self.countNavigationItem = [[BIZCountNavigationItem alloc] initWithTarget:self action:@selector(countNavigationItemAction:)];
    self.countNavigationItem.badgeLabel.textColor = [UIColor whiteColor];
    self.countNavigationItem.badgeLabel.backgroundColor = [UIColor grayColor];
    self.countNavigationItem.badgeLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.rightBarButtonItem = self.countNavigationItem;
}

- (void)countNavigationItemAction:(BIZCountNavigationItem *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Clicked" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)plusButtonAction:(UIButton *)sender
{
    self.count++;
}

- (IBAction)minusButtonAction:(UIButton *)sender
{
    self.count--;
}

- (void)setCount:(NSInteger)count
{
    if (count < 0) {
        count = 0;
    }
    _count = count;
    self.countNavigationItem.count = self.count;
}

@end
