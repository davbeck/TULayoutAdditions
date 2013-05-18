//
//  UIView+TULayoutAdditions.h
//  TULayoutAdditions
//
//  Created by David Beck on 5/10/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TUConstraintInfo.h"


typedef void(^TUConstraintsBlock)();

extern BOOL TUAutoAddConstraint(NSLayoutConstraint *constraint) __attribute__((deprecated));


@interface UIView (TULayoutAdditions)

- (UIView *)ancestorSharedWithView:(UIView *)aView;
- (BOOL)isSubviewOfView:(UIView *)view;

@property (nonatomic, copy) id constrainedLeft;
@property (nonatomic, copy) id constrainedRight;
@property (nonatomic, copy) id constrainedTop;
@property (nonatomic, copy) id constrainedBottom;
@property (nonatomic, copy) id constrainedLeading;
@property (nonatomic, copy) id constrainedTrailing;
@property (nonatomic, copy) id constrainedWidth;
@property (nonatomic, copy) id constrainedHeight;
@property (nonatomic, copy) id constrainedCenterX;
@property (nonatomic, copy) id constrainedCenterY;
@property (nonatomic, copy) id constrainedBaseline;

+ (NSArray *)constraintsWithBlock:(TUConstraintsBlock)block;

@end
