//
//  AnimatorTransitioningDelegate.m
//  iOS10ModelPresent
//
//  Created by SlowWalker on 21/05/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import "AnimatorTransitioningDelegate.h"
#import "AnimatorController.h"
#import "AnimatorPresentationController.h"

@implementation AnimatorTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[AnimatorController alloc] init];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {

    return [[AnimatorPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
