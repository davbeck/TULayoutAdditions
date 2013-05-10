//
//  UIView+TULayoutAdditions.m
//  TULayoutAdditions
//
//  Created by David Beck on 5/10/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import "UIView+TULayoutAdditions.h"

#import "NSNumber+TULayoutAdditions.h"


BOOL TUAutoAddConstraint(NSLayoutConstraint *constraint)
{
    UIView *parentView = [constraint.firstItem ancestorSharedWithView:constraint.secondItem];
    
    if (parentView != nil) {
        if (![constraint.secondItem isSubviewOfView:constraint.firstItem]) {
            [constraint.firstItem setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        if (![constraint.firstItem isSubviewOfView:constraint.secondItem]) {
            [constraint.secondItem setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [parentView addConstraint:constraint];
        
        return YES;
    }
    
    return NO;
}


@implementation UIView (TULayoutAdditions)

- (UIView *)ancestorSharedWithView:(UIView *)aView
{
    UIView *parentView = nil;
    
    if (aView != nil) {
        UIView *nextView = self;
        
        while (nextView != nil && parentView == nil) {
            if ([aView isSubviewOfView:nextView]) {
                parentView = nextView;
            }
            
            nextView = nextView.superview;
        }
    } else {
        parentView = self;
    }
    
    return parentView;
}

- (BOOL)isSubviewOfView:(UIView *)view
{
    UIView *child = self;
    while (child != nil) {
        if (child == view) {
            return YES;
        }
        
        child = child.superview;
    }
    
    return NO;
}

+ (NSArray *)locationAttributes
{
    static NSArray *locationAttributes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationAttributes = @[
                               @(NSLayoutAttributeLeft),
                               @(NSLayoutAttributeRight),
                               @(NSLayoutAttributeTop),
                               @(NSLayoutAttributeBottom),
                               @(NSLayoutAttributeLeading),
                               @(NSLayoutAttributeTrailing),
                               @(NSLayoutAttributeCenterX),
                               @(NSLayoutAttributeCenterY),
                               @(NSLayoutAttributeBaseline),
                               ];
    });
    
    return locationAttributes;
}

+ (BOOL)attributeIsLocation:(NSLayoutAttribute)attribute
{
    return [[self locationAttributes] containsObject:@(attribute)];
}

- (void)setConstrainedAttribute:(NSLayoutAttribute)attribute constraint:(TUConstraintInfo *)constraint
{
    if ([constraint isKindOfClass:[NSNumber class]]) {
        constraint = [(NSNumber *)constraint constraint];
    }
    
    UIView *toItem = constraint.toItem;
    NSLayoutAttribute toAttribute = constraint.toAttribute;
    if (toItem == nil && [[self class] attributeIsLocation:attribute]) {
        toItem = self.superview;
        toAttribute = attribute;
    }
    
    
    NSLayoutConstraint * layoutConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                         attribute:attribute
                                                                         relatedBy:constraint.relation
                                                                            toItem:toItem
                                                                         attribute:toAttribute
                                                                        multiplier:constraint.multiplier
                                                                          constant:constraint.constant];
    layoutConstraint.priority = constraint.priority;
    
    TUAutoAddConstraint(layoutConstraint);
}

- (TUConstraintInfo *)constraintWithAttribute:(NSLayoutAttribute)attribute
{
    return [[TUConstraintInfo alloc] initWithItem:self attribute:attribute];
}


#pragma mark - Constraints

- (void)setConstrainedLeft:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeLeft constraint:constraint];
}

- (TUConstraintInfo *)constrainedLeft
{
    return [self constraintWithAttribute:NSLayoutAttributeLeft];
}

- (void)setConstrainedRight:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeRight constraint:constraint];
}

- (TUConstraintInfo *)constrainedRight
{
    return [self constraintWithAttribute:NSLayoutAttributeRight];
}

- (void)setConstrainedTop:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeTop constraint:constraint];
}

- (TUConstraintInfo *)constrainedTop
{
    return [self constraintWithAttribute:NSLayoutAttributeTop];
}

- (void)setConstrainedBottom:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeBottom constraint:constraint];
}

- (TUConstraintInfo *)constrainedBottom
{
    return [self constraintWithAttribute:NSLayoutAttributeBottom];
}

- (void)setConstrainedLeading:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeLeading constraint:constraint];
}

- (TUConstraintInfo *)constrainedLeading
{
    return [self constraintWithAttribute:NSLayoutAttributeLeading];
}

- (void)setConstrainedTrailing:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeTrailing constraint:constraint];
}

- (TUConstraintInfo *)constrainedTrailing
{
    return [self constraintWithAttribute:NSLayoutAttributeTrailing];
}

- (void)setConstrainedWidth:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeWidth constraint:constraint];
}

- (TUConstraintInfo *)constrainedWidth
{
    return [self constraintWithAttribute:NSLayoutAttributeWidth];
}

- (void)setConstrainedHeight:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeHeight constraint:constraint];
}

- (TUConstraintInfo *)constrainedHeight
{
    return [self constraintWithAttribute:NSLayoutAttributeHeight];
}

- (void)setConstrainedCenterX:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeCenterX constraint:constraint];
}

- (TUConstraintInfo *)constrainedCenterX
{
    return [self constraintWithAttribute:NSLayoutAttributeCenterX];
}

- (void)setConstrainedCenterY:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeCenterY constraint:constraint];
}

- (TUConstraintInfo *)constrainedCenterY
{
    return [self constraintWithAttribute:NSLayoutAttributeCenterY];
}

- (void)setConstrainedBaseline:(TUConstraintInfo *)constraint
{
    [self setConstrainedAttribute:NSLayoutAttributeBaseline constraint:constraint];
}

- (TUConstraintInfo *)constrainedBaseline
{
    return [self constraintWithAttribute:NSLayoutAttributeBaseline];
}

@end
