//
//  AnimationPresentationController.m
//  iOS10ModelPresent
//
//  Created by SlowWalker on 20/05/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import "AnimatorPresentationController.h"

@implementation AnimatorPresentationController

- (CGRect)frameOfPresentedViewInContainerView {

    if (self.containerView != nil) {
        CGFloat offset = 28.0;
        return CGRectMake(0, offset, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
    }

    return CGRectZero;
}

- (void)presentationTransitionDidEnd:(BOOL)completed {

    if (completed) {
        CGFloat scale = 1 - (40 / self.presentingViewController.view.frame.size.height);
        self.presentingViewController.view.transform = CGAffineTransformMakeScale(scale, scale);
        self.presentingViewController.view.alpha = 0.8;

        self.presentedViewController.view.frame = self.frameOfPresentedViewInContainerView;
    }

}

- (void)dismissalTransitionDidEnd:(BOOL)completed {

    if (completed) {
        self.presentingViewController.view.alpha = 1;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
        self.presentingViewController.view.layer.cornerRadius = 0;

        CGSize size = self.containerView.bounds.size;
        CGRect offScreenFrame = CGRectMake(0, size.height,
                                           size.width, size.height);
        self.presentedViewController.view.frame = offScreenFrame;
    }

}

@end
