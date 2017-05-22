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
//                                 [transitionContext completeTransition:YES];
                             } completion:^(BOOL finished) {
                                 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             }];
            break;
        };
        case AnimatorPresent: {
            [[transitionContext containerView] addSubview:toViewController.view];
            toViewController.view.frame = offScreenFrame;
            CGRect toFinalFrame = toViewController.view.frame;
            toFinalFrame.origin.y = 28;

            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                CGFloat scale = 1 - (40 / fromViewController.view.frame.size.height);
                fromViewController.view.transform = CGAffineTransformMakeScale(scale, scale);
//                fromViewController.view.frame = toFinalFrame;
                fromViewController.view.alpha = 0.8;
                fromViewController.view.layer.cornerRadius = 8;
                fromViewController.view.layer.masksToBounds = YES;

                toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
                [toViewController.view roundAt:UIRectCornerTopLeft | UIRectCornerTopRight withRadius:8.0];
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];

            break;
        };
    }

}

@end
