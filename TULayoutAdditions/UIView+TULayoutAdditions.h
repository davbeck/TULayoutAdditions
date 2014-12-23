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

- (NSLayoutConstraint *)constraintWithAttribute:(NSLayoutAttribute)attribute info:(TUConstraintInfo *)info;
- (void)setConstraintWithAttribute:(NSLayoutAttribute)attribute info:(TUConstraintInfo *)constraint;
- (TUConstraintInfo *)constraintInfoWithAttribute:(NSLayoutAttribute)attribute;

@property (nonatomic, copy) id<TUConstraintInfo> constrainedLeft;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedRight;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedTop;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedBottom;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedLeading;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedTrailing;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedWidth;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedHeight;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedCenterX;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedCenterY;
@property (nonatomic, copy) id<TUConstraintInfo> constrainedBaseline;

+ (NSArray *)constraintsWithBlock:(TUConstraintsBlock)block;

@end
