//
//  TUConstraintInfo.h
//  TULayoutAdditions
//
//  Created by David Beck on 5/10/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TUConstraintInfo : NSObject

- (id)initWithItem:(UIView *)item attribute:(NSLayoutAttribute)attribute;

@property (nonatomic, readonly) NSLayoutRelation relation;
- (instancetype)withRelation:(NSLayoutRelation)relation;
- (instancetype)greaterThanOrEqual;
- (instancetype)lessThanOrEqual;
- (instancetype)equal;

@property (nonatomic, readonly, strong) UIView *toItem;
@property (nonatomic, readonly) NSLayoutAttribute toAttribute;

@property (nonatomic, readonly) CGFloat constant;
- (instancetype)withConstant:(CGFloat)constant;

@property (nonatomic, readonly) CGFloat multiplier;
- (instancetype)withMultiplier:(CGFloat)multiplier;

@property (nonatomic, readonly) UILayoutPriority priority;
- (instancetype)withPriority:(UILayoutPriority)priority;

// Order of operations doesn't apply. The equation will always be mX + b.
- (instancetype)plus:(CGFloat)value;
- (instancetype)minus:(CGFloat)value;
- (instancetype)times:(CGFloat)value;
- (instancetype)dividedBy:(CGFloat)value;

@end
