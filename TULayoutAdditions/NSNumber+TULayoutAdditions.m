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

@end
