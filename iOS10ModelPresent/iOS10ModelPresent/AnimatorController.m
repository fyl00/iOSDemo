//
//  AnimationController.m
//  iOS10ModelPresent
//
//  Created by SlowWalker on 18/05/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import "AnimatorController.h"
#import "UIView+Round.h"

@implementation AnimatorController

- (id)initWithType:(TransitionType)type {
    if (self == nil) {
        self = [[AnimatorController alloc] init];
    }
    self.transitionType = type;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.48;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    CGRect toOriginFrame = toViewController.view.frame;
    toOriginFrame.origin.y = [UIScreen mainScreen].bounds.size.height;
    toViewController.view.frame = toOriginFrame;
    CGRect toFinalFrame = toViewController.view.frame;
    toFinalFrame.origin.y = 28;


    CGRect offScreenFrame = CGRectMake(0, transitionContext.containerView.bounds.size.height,
                                       transitionContext.containerView.bounds.size.width, transitionContext.containerView.bounds.size.height);
    switch (self.transitionType) {
        case AnimatorDismiss: {
            [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 toViewController.view.alpha = 1;
                                 toViewController.view.transform = CGAffineTransformIdentity;
                                 toViewController.view.layer.cornerRadius = 0;

                                 fromViewController.view.frame = offScreenFrame;

                             } completion:^(BOOL finished) {
                                 [transitionContext completeTransition:finished];
                             }];
            break;
        };
        case AnimatorPresent: {

            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                CGFloat scale = 1 - (40 / fromViewController.view.frame.size.height);
                fromViewController.view.transform = CGAffineTransformMakeScale(scale, scale);
//                fromViewController.view.transform = CGAffineTransformIdentity;
                fromViewController.view.alpha = 0.8;
                fromViewController.view.layer.cornerRadius = 8;
                fromViewController.view.layer.masksToBounds = YES;

                toViewController.view.frame = toFinalFrame;
                [toViewController.view roundAt:UIRectCornerTopLeft | UIRectCornerTopRight withRadius:8.0];
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];

            break;
        };
    }

}

@end
