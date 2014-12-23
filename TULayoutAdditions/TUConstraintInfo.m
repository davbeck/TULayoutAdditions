//
//  TUConstraintInfo.m
//  TULayoutAdditions
//
//  Created by David Beck on 5/10/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import "TUConstraintInfo.h"

#import "NSLayoutConstraint+TULayoutAdditions.h"


@implementation TUConstraintInfo

- (id)init
{
    self = [super init];
    if (self != nil) {
        _relation = NSLayoutRelationEqual;
        _multiplier = 1.0;
        _constant = 0.0;
        _priority = UILayoutPriorityRequired;
    }
    
    return self;
}

- (id)initWithItem:(UIView *)item attribute:(NSLayoutAttribute)attribute
{
    self = [self init];
    if (self != nil) {
        _toItem = item;
        _toAttribute = attribute;
    }
    
    return self;
}

- (id)initWithView:(UIView *)view guide:(id<UILayoutSupport>)guide attribute:(NSLayoutAttribute)attribute
{
    self = [self init];
    if (self != nil) {
        _toItem = guide;
        _toAttribute = attribute;
        
        TULayoutAdditionsSetGuideView(guide, view);
    }
    
    return self;
}

- (instancetype)withRelation:(NSLayoutRelation)relation
{
    _relation = relation;
    
    return self;
}

- (instancetype)greaterThanOrEqual
{
    return [self withRelation:NSLayoutRelationGreaterThanOrEqual];
}

- (instancetype)lessThanOrEqual
{
    return [self withRelation:NSLayoutRelationLessThanOrEqual];
}

- (instancetype)equal
{
    return [self withRelation:NSLayoutRelationEqual];
}

- (instancetype)withConstant:(CGFloat)constant
{
    _constant = constant;
    
    return self;
}

- (instancetype)withMultiplier:(CGFloat)multiplier
{
    _multiplier = multiplier;
    
    return self;
}

- (instancetype)withPriority:(UILayoutPriority)priority
{
    _priority = priority;
    
    return self;
}

- (instancetype)plus:(CGFloat)value
{
    return [self withConstant:self.constant + value];
}

- (instancetype)minus:(CGFloat)value
{
    return [self withConstant:self.constant - value];
}

- (instancetype)times:(CGFloat)value
{
    return [self withMultiplier:self.multiplier * value];
}

- (instancetype)dividedBy:(CGFloat)value
{
    return [self withMultiplier:self.multiplier * (1.0 / value)];
}

@end
