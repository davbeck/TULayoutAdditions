//
//  UIViewController+TULayoutAdditions.h
//  TULayoutAdditions
//
//  Created by David Beck on 12/22/14.
//  Copyright (c) 2014 ThinkUltimate. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TUConstraintInfo.h"


@interface UIViewController (TULayoutAdditions)

@property (nonatomic, copy) id<TUConstraintInfo> constrainedTopLayoutGuide;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedBottomLayoutGuide;

@end
