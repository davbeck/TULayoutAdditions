//
//  UIView+TULayoutAdditions.m
//  TULayoutAdditions
//
//  Created by David Beck on 5/10/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import "UIView+TULayoutAdditions.h"

#import "NSNumber+TULayoutAdditions.h"
#import "NSLayoutConstraint+TULayoutAdditions.h"


#define TUAddedConstraintsKey @"TUAddedConstraints"


BOOL TUAutoAddConstraint(NSLayoutConstraint *constraint)
{
    return [constraint add];
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

- (NSLayoutConstraint *)constraintWithAttribute:(NSLayoutAttribute)attribute info:(TUConstraintInfo *)info
{
    if ([info isKindOfClass:[NSNumber class]]) {
        info = [(NSNumber *)info constraint];
    }
    
    UIView *toItem = info.toItem;
    NSLayoutAttribute toAttribute = info.toAttribute;
    if (toItem == nil && [[self class] attributeIsLocation:attribute]) {
        toItem = self.superview;
        toAttribute = attribute;
    }
    
    
    NSLayoutConstraint * layoutConstraint = [NSLayoutConstraint constraintWithItem:self
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

- (void)setConstraintWithAttribute:(NSLayoutAttribute)attribute info:(TUConstraintInfo *)info
{
    NSLayoutConstraint *layoutConstraint = [self constraintWithAttribute:attribute info:info];
    
    [layoutConstraint add];
}

- (TUConstraintInfo *)constraintInfoWithAttribute:(NSLayoutAttribute)attribute
{
    return [[TUConstraintInfo alloc] initWithItem:self attribute:attribute];
}


#pragma mark - Constraints

- (void)setConstrainedLeft:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeLeft info:constraint];
}

- (TUConstraintInfo *)constrainedLeft
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeLeft];
}

- (void)setConstrainedRight:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeRight info:constraint];
}

- (TUConstraintInfo *)constrainedRight
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeRight];
}

- (void)setConstrainedTop:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeTop info:constraint];
}

- (TUConstraintInfo *)constrainedTop
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeTop];
}

- (void)setConstrainedBottom:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeBottom info:constraint];
}

- (TUConstraintInfo *)constrainedBottom
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeBottom];
}

- (void)setConstrainedLeading:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeLeading info:constraint];
}

- (TUConstraintInfo *)constrainedLeading
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeLeading];
}

- (void)setConstrainedTrailing:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeTrailing info:constraint];
}

- (TUConstraintInfo *)constrainedTrailing
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeTrailing];
}

- (void)setConstrainedWidth:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeWidth info:constraint];
}

- (TUConstraintInfo *)constrainedWidth
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeWidth];
}

- (void)setConstrainedHeight:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeHeight info:constraint];
}

- (TUConstraintInfo *)constrainedHeight
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeHeight];
}

- (void)setConstrainedCenterX:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeCenterX info:constraint];
}

- (TUConstraintInfo *)constrainedCenterX
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeCenterX];
}

- (void)setConstrainedCenterY:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeCenterY info:constraint];
}

- (TUConstraintInfo *)constrainedCenterY
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeCenterY];
}

- (void)setConstrainedBaseline:(TUConstraintInfo *)constraint
{
    [self setConstraintWithAttribute:NSLayoutAttributeBaseline info:constraint];
}

- (TUConstraintInfo *)constrainedBaseline
{
    return [self constraintInfoWithAttribute:NSLayoutAttributeBaseline];
}

+ (NSArray *)constraintsWithBlock:(TUConstraintsBlock)block
{
    NSMutableArray *originalConstraints = [NSThread currentThread].threadDictionary[TUAddedConstraintsKey];
    
    
    [NSThread currentThread].threadDictionary[TUAddedConstraintsKey] = [NSMutableArray new];
    
    block();
    
    NSArray *newConstraints = [NSThread currentThread].threadDictionary[TUAddedConstraintsKey];
    
    
    if (originalConstraints != nil) {
        [originalConstraints addObjectsFromArray:newConstraints];
        [NSThread currentThread].threadDictionary[TUAddedConstraintsKey] = originalConstraints;
    } else {
        [[NSThread currentThread].threadDictionary removeObjectForKey:TUAddedConstraintsKey];
    }
    
    return newConstraints;
}

@end
