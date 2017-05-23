//
//  AnimatorInteractive.m
//  iOS10ModelPresent
//
//  Created by SlowWalker on 22/05/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import "AnimatorInteractive.h"

@interface AnimatorInteractive()

@property (nonatomic) BOOL shouldComplete;
@property (nonatomic) UIGestureRecognizer *pan;

@end

@implementation AnimatorInteractive

- (void)registerGestureto:(UIViewController *)toVC {

    self.toVC = toVC;
    if (self.pan == nil) {
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    }
    [self.toVC.view addGestureRecognizer:self.pan];

}

- (void)handleGesture:(UIPanGestureRecognizer *)pan {

    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            self.interactionInProgress = YES;
            [self.toVC dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGPoint transition = [pan translationInView:pan.view.superview];
            CGFloat originHeight = [UIScreen mainScreen].bounds.size.height - 28;
            CGFloat percent = transition.y / originHeight;
            self.shouldComplete = percent > 0.28;

            [self updateInteractiveTransition:percent];
            break;

        }

        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if (self.shouldComplete) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            self.interactionInProgress = NO;
            break;
        }
        default:
            break;
    }

}

- (void)finishInteractiveTransition {
    [super finishInteractiveTransition];
    [self.toVC.view removeGestureRecognizer: self.pan];
}

@end
