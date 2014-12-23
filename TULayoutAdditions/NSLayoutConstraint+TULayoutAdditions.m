//
//  NSLayoutConstraint+TULayoutAdditions.m
//  TULayoutAdditions
//
//  Created by David Beck on 5/18/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import "NSLayoutConstraint+TULayoutAdditions.h"

#import <objc/runtime.h>

#import "UIView+TULayoutAdditions.h"


const void *TULayoutAdditionsGuideViewKey = &TULayoutAdditionsGuideViewKey;

void TULayoutAdditionsSetGuideView(id<UILayoutSupport> guide, UIView *view)
{
    objc_setAssociatedObject(guide, TULayoutAdditionsGuideViewKey, view, OBJC_ASSOCIATION_ASSIGN);
}

UIView *TULayoutAdditionsGetGuideView(id<UILayoutSupport> guide)
{
    return objc_getAssociatedObject(guide, TULayoutAdditionsGuideViewKey);
}


@implementation NSLayoutConstraint (TULayoutAdditions)

- (BOOL)add
{
    UIView *firstView = self.firstItem;
    if ([firstView conformsToProtocol:@protocol(UILayoutSupport)]) {
        firstView = TULayoutAdditionsGetGuideView(self.firstItem);
    }
    UIView *secondView = self.secondItem;
    if ([secondView conformsToProtocol:@protocol(UILayoutSupport)]) {
        secondView = TULayoutAdditionsGetGuideView(self.secondItem);
    }
    
    UIView *parentView = [firstView ancestorSharedWithView:secondView];
    
    if (parentView != nil) {
        if (![secondView isSubviewOfView:firstView]) {
            [firstView setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        if (![firstView isSubviewOfView:secondView]) {
            [secondView setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [parentView addConstraint:self];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)remove
{
    UIView *firstView = self.firstItem;
    if ([firstView conformsToProtocol:@protocol(UILayoutSupport)]) {
        firstView = TULayoutAdditionsGetGuideView(self.firstItem);
    }
    UIView *secondView = self.secondItem;
    if ([secondView conformsToProtocol:@protocol(UILayoutSupport)]) {
        secondView = TULayoutAdditionsGetGuideView(self.secondItem);
    }
    
    UIView *parentView = [firstView ancestorSharedWithView:secondView];
    
    if ([parentView.constraints containsObject:self]) {
        [parentView removeConstraint:self];
        
        return YES;
    } else {
        UIView *nextView = firstView;
        
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
