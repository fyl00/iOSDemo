//
//  ViewController.m
//  iOS10ModelPresent
//
//  Created by SlowWalker on 18/05/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import "ViewController.h"
#import "ModelViewController.h"
#import "AnimatorController.h"
#import "AnimatorPresentationController.h"
#import "AnimatorInteractive.h"

@interface ViewController ()

@property (nonatomic) AnimatorInteractive *dismissInteractor;
@property (nonatomic) AnimatorController *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_addVCButton addTarget:self action:@selector(presentChildVC) forControlEvents:UIControlEventTouchUpInside];
    self.animator = [[AnimatorController alloc] init];
    self.dismissInteractor = [[AnimatorInteractive alloc] initWithAnimator:self.animator];
}


- (void)presentChildVC {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ModelViewController *childViewController = [storyboard instantiateViewControllerWithIdentifier:@"ModelViewController"];
    childViewController.transitioningDelegate = self;
    childViewController.modalPresentationStyle = UIModalPresentationCustom;

    [self.dismissInteractor registerGestureto:childViewController];

    [self presentViewController:childViewController animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animator.transitionType = AnimatorPresent;
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animator.transitionType = AnimatorDismiss;
    return self.animator;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[AnimatorPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    // 如果在非交互的情况下不返回 nil，
    // `(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext`
    // 里面的 `(void)animateWithDuration:` 可能无法完成
    return self.dismissInteractor.interactionInProgress ? self.dismissInteractor : nil;
}

@end
