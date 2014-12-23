//
//  NSNumber+TULayoutAdditions.h
//  TULayoutAdditions
//
//  Created by David Beck on 5/10/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TUConstraintInfo.h"


@interface NSNumber (TULayoutAdditions) <TUConstraintInfo>

@property (nonatomic, readonly) TUConstraintInfo *constraint;

@end
