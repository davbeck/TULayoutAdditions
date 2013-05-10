//
//  TUViewController.m
//  TULayoutAdditions
//
//  Created by David Beck on 5/10/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import "TUViewController.h"

#import "TULayoutAdditions.h"


@interface TUViewController ()

@end

@implementation TUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:0.500];
    [self.view addSubview:blueView];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.500];
    [self.view addSubview:redView];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = [UIColor colorWithRed:0.000 green:1.000 blue:0.000 alpha:0.500];
    [self.view addSubview:greenView];
    
    
    blueView.constrainedHeight = @50;
    blueView.constrainedWidth = @100;
    blueView.constrainedTop = @80;
    blueView.constrainedLeft = @20;
    
    redView.constrainedLeft = [blueView.constrainedRight withConstant:20.0];
    redView.constrainedTop = @50;
    redView.constrainedBottom = @-150;
    redView.constrainedRight = @-100;
    
    greenView.constrainedTop = [[blueView.constrainedBottom greaterThanOrEqual] withConstant:10.0];
    greenView.constrainedBottom = redView.constrainedBottom;
    greenView.constrainedHeight = [[@100 constraint] withPriority:UILayoutPriorityDefaultLow];
    greenView.constrainedRight = [redView.constrainedLeft withConstant:-10];
    greenView.constrainedLeft = @10;
}

@end
