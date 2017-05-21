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

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_addVCButton addTarget:self action:@selector(presentChildVC) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentChildVC {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ModelViewController *childViewController = [storyboard instantiateViewControllerWithIdentifier:@"ModelViewController"];
    childViewController.transitioningDelegate = self;
    childViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:childViewController animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[AnimatorController alloc] initWithType: AnimatorPresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[AnimatorController alloc] initWithType: AnimatorDismiss];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {

    return [[AnimatorPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}



@end
