//
//  NSNumber+TULayoutAdditions.m
//  TULayoutAdditions
//
//  Created by David Beck on 5/10/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import "NSNumber+TULayoutAdditions.h"

@implementation NSNumber (TULayoutAdditions)

- (TUConstraintInfo *)constraint
{
    TUConstraintInfo *constraint = [TUConstraintInfo new];
    
    return [constraint withConstant:self.doubleValue];
}

- (TUConstraintInfo *)withRelation:(NSLayoutRelation)relation
{
    return [self.constraint withRelation:relation];
}

- (TUConstraintInfo *)greaterThanOrEqual
{
    return [self.constraint greaterThanOrEqual];
}

- (TUConstraintInfo *)lessThanOrEqual
{
    return [self.constraint lessThanOrEqual];
}

- (TUConstraintInfo *)equal
{
    return [self.constraint equal];
}

- (TUConstraintInfo *)withConstant:(CGFloat)constant
{
    return [self.constraint withConstant:constant];
}

- (TUConstraintInfo *)withMultiplier:(CGFloat)multiplier
{
    return [self.constraint withMultiplier:multiplier];
}

- (TUConstraintInfo *)withPriority:(UILayoutPriority)priority
{
    return [self.constraint withPriority:priority];
}

- (NSNumber *)plus:(CGFloat)value
{
    return @(self.doubleValue + value);
}

- (NSNumber *)minus:(CGFloat)value
{
    return @(self.doubleValue - value);
}

- (NSNumber *)times:(CGFloat)value
{
    return @(self.doubleValue * value);
}

- (NSNumber *)dividedBy:(CGFloat)value
{
    return @(self.doubleValue / value);
}

@end
