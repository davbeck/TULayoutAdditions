//
//  TUConstraintInfo.h
//  TULayoutAdditions
//
//  Created by David Beck on 5/10/13.
//  Copyright (c) 2013 ThinkUltimate. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TUConstraintInfo <NSObject>

- (id<TUConstraintInfo>)withRelation:(NSLayoutRelation)relation;
- (id<TUConstraintInfo>)greaterThanOrEqual;
- (id<TUConstraintInfo>)lessThanOrEqual;
- (id<TUConstraintInfo>)equal;

- (id<TUConstraintInfo>)withConstant:(CGFloat)constant;
- (id<TUConstraintInfo>)withMultiplier:(CGFloat)multiplier;
- (id<TUConstraintInfo>)withPriority:(UILayoutPriority)priority;

// Order of operations doesn't apply. The equation will always be mX + b.
- (id<TUConstraintInfo>)plus:(CGFloat)value;
- (id<TUConstraintInfo>)minus:(CGFloat)value;
- (id<TUConstraintInfo>)times:(CGFloat)value;
- (id<TUConstraintInfo>)dividedBy:(CGFloat)value;

@end


@interface TUConstraintInfo : NSObject <TUConstraintInfo>

- (id)initWithItem:(UIView *)item attribute:(NSLayoutAttribute)attribute;
- (id)initWithView:(UIView *)view guide:(id<UILayoutSupport>)guide attribute:(NSLayoutAttribute)attribute;

@property (nonatomic, readonly) NSLayoutRelation relation;

@property (nonatomic, readonly, strong) id toItem;
@property (nonatomic, readonly) NSLayoutAttribute toAttribute;
@property (nonatomic, readonly, strong) id<UILayoutSupport> guide;

@property (nonatomic, readonly) CGFloat constant;

@property (nonatomic, readonly) CGFloat multiplier;

@property (nonatomic, readonly) UILayoutPriority priority;

@end
