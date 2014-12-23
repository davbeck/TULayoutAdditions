//
//  NSLayoutConstraint+TULayoutAdditions.h
//  TULayoutAdditions
//
//  Created by David Beck on 5/18/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import <UIKit/UIKit.h>


void TULayoutAdditionsSetGuideView(id<UILayoutSupport> guide, UIView *view);
UIView *TULayoutAdditionsGetGuideView(id<UILayoutSupport> guide);


@interface NSLayoutConstraint (TULayoutAdditions)

- (BOOL)add;
- (BOOL)remove;

@end
