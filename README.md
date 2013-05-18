# TULayoutAdditions

`TULayoutAdditions` is a collection of helper objects and categories that makes auto layout on iOS dead simple.

## Installation

### CocoaPods

1. Add `pod 'TULayoutAdditions'` to your Podfile.
2. Import `TULayoutAdditions.h`.

### Manually

1. Copy the TULayoutAdditions subfolder into your project.
2. The only required framework is UIKit and iOS 6.0.
3. Import `TULayoutAdditions.h`.

## Example

> See the example project.

With traditional auto layout, you would write all this:

    greenView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[greenView]-(10)-[redView]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(redView, greenView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[blueView]-(>=10)-[greenView(100@250)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(blueView, greenView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:redView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];

But with `TULayoutAdditions`, you would do the following:

    greenView.constrainedTop = [[blueView.constrainedBottom greaterThanOrEqual] plus:10.0];
    greenView.constrainedBottom = redView.constrainedBottom;
    greenView.constrainedHeight = [[@100 constraint] withPriority:UILayoutPriorityDefaultLow];
    greenView.constrainedRight = [redView.constrainedLeft minus:10.0];
    greenView.constrainedLeft = @10;

While the visual formatting language is useful, the large amount of options, need to pass in the views you use, and the fact that it is represented as a string that cannot produce warnings at compile time or auto complete, make it cumbersome and time consuming to write.

`TULayoutAdditions` is centered around properties starting with `constrained`, i.e. `constrainedHeight`, `constrainedCetnerX`, etc. When you get one of these properties, an instance of `TUConstraintInfo` is created with the info about the view and the attribute. You can then manipulate properties and even chain them together. Alternatively, you can use and NSNumber to generate a `TUConstraintInfo` object, which will work as a constant, such as with height and width, or for position attributes (top, left, center, etc.) will implicitly use superview.

Note that the order of operations for `plus`/`minus`/`times`/`dividedBy` do not apply. If you add first, and then multiply, the constant will not be multiplied. The function will always be `mX + b`.

Once you have a `TUConstraintInfo` object, you can then set it on another view's `constrained` attribute. When you set constraint info on a view, it automatically creates a constraint and adds it to the correct view. It also sets `translatesAutoresizingMaskIntoConstraints` on both views, unless one is a superview of the other (that is done so that setting a constraint automatically does not invalidate superview constraints).

You can get a reference to the created `NSLayoutConstraint` in one of two ways.

### Blocks

You can create all the constraints inside of a block using `+[UIView constraintsWithBlock:]` and then get an array of all the constraints created.

    NSArray *greenConstraints = [UIView constraintsWithBlock:^{
        greenView.constrainedTop = [[blueView.constrainedBottom greaterThanOrEqual] plus:10.0];
        greenView.constrainedBottom = redView.constrainedBottom;
        greenView.constrainedHeight = [[@100 constraint] withPriority:UILayoutPriorityDefaultLow];
        greenView.constrainedRight = [redView.constrainedLeft minus:10.0];
        greenView.constrainedLeft = @10;
    }];

The returned constraints will only include those created with the `setConstrainedX:` methods, or the `-[UIView setConstraintWithAttribute:info:` method.

Each `setConstrainedX:` method is guaranteed to create one and only one constraint each time it is called. That means you can reliably do the following:

    NSLayoutConstraint *greenConstraint = [UIView constraintsWithBlock:^{
        greenView.constrainedLeft = @10;
    }].lastObject;

### Manually create and add constraints

The `setConstrainedX:` methods just call `-[UIView setConstraintWithAttribute:info:]` with the corresponding `NSLayoutAttribute`, which in turn calls `-[UIView constraintWithAttribute:info:]` and adds it. You can use these methods yourself:

    NSLayoutConstraint *constraint = [greenView constraintWithAttribute:NSLayoutAttributeLeft info:@10];
    [constraint add];