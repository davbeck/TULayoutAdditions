//
//  NSLayoutConstraint+TULayoutAdditions.m
//  TULayoutAdditions
//
//  Created by David Beck on 5/18/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import "NSLayoutConstraint+TULayoutAdditions.h"

#import "UIView+TULayoutAdditions.h"


@implementation NSLayoutConstraint (TULayoutAdditions)

- (BOOL)add
{
    UIView *parentView = [self.firstItem ancestorSharedWithView:self.secondItem];
    
    if (parentView != nil) {
        if (![self.secondItem isSubviewOfView:self.firstItem]) {
            [self.firstItem setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        if (![self.firstItem isSubviewOfView:self.secondItem]) {
            [self.secondItem setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [parentView addConstraint:self];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)remove
{
    UIView *parentView = [self.firstItem ancestorSharedWithView:self.secondItem];
    
    if ([parentView.constraints containsObject:self]) {
        [parentView removeConstraint:self];
        
        return YES;
    } else {
        UIView *nextView = self.firstItem;
        
        while (nextView != nil) {
            if ([nextView.constraints containsObject:self]) {
                [nextView removeConstraint:self];
                
                return YES;
            }
            
            nextView = nextView.superview;
        }
    }
    
    return NO;
}

@end
