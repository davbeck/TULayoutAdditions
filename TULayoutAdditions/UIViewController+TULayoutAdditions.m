//
//  UIViewController+TULayoutAdditions.m
//  TULayoutAdditions
//
//  Created by David Beck on 12/22/14.
//  Copyright (c) 2014 ThinkUltimate. All rights reserved.
//

#import "UIViewController+TULayoutAdditions.h"

#import "NSNumber+TULayoutAdditions.h"
#import "NSLayoutConstraint+TULayoutAdditions.h"


#define TUAddedConstraintsKey @"TUAddedConstraints"


@implementation UIViewController (TULayoutAdditions)

- (NSLayoutConstraint *)constraintWithAttribute:(NSLayoutAttribute)attribute guide:(id<UILayoutSupport>)guide info:(TUConstraintInfo *)info
{
    if ([info isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    
    UIView *toItem = info.toItem;
    NSLayoutAttribute toAttribute = info.toAttribute;
    if (toItem == nil) {
        return nil;
    }
    
    
    TULayoutAdditionsSetGuideView(guide, self.view);
    NSLayoutConstraint * layoutConstraint = [NSLayoutConstraint constraintWithItem:guide
                                                                         attribute:attribute
                                                                         relatedBy:info.relation
                                                                            toItem:toItem
                                                                         attribute:toAttribute
                                                                        multiplier:info.multiplier
                                                                          constant:info.constant];
    layoutConstraint.priority = info.priority;
    
    [[NSThread currentThread].threadDictionary[TUAddedConstraintsKey] addObject:layoutConstraint];
    
    return layoutConstraint;
}

- (void)setConstrainedTopLayoutGuide:(id<TUConstraintInfo>)constraint
{
    NSLayoutConstraint *layoutConstraint = [self constraintWithAttribute:NSLayoutAttributeBottom guide:self.topLayoutGuide info:constraint];
    
    [layoutConstraint add];
}

- (TUConstraintInfo *)constrainedTopLayoutGuide
{
    return [[TUConstraintInfo alloc] initWithView:self.view guide:self.topLayoutGuide attribute:NSLayoutAttributeBottom];
}

- (void)setConstrainedBottomLayoutGuide:(id<TUConstraintInfo>)constraint
{
    NSLayoutConstraint *layoutConstraint = [self constraintWithAttribute:NSLayoutAttributeTop guide:self.bottomLayoutGuide info:constraint];
    
    [layoutConstraint add];
}

- (TUConstraintInfo *)constrainedBottomLayoutGuide
{
    return [[TUConstraintInfo alloc] initWithView:self.view guide:self.bottomLayoutGuide attribute:NSLayoutAttributeTop];
}

@end
