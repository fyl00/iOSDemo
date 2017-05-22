//
//  AnimatorInteractive.h
//  iOS10ModelPresent
//
//  Created by SlowWalker on 22/05/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AnimatorController.h"

@interface AnimatorInteractive: UIPercentDrivenInteractiveTransition

@property (nonatomic) UIViewController *toVC;
@property (nonatomic) UIViewController *fromVC;
@property (nonatomic) BOOL interactionInProgress;

- (id)initWithAnimator:(AnimatorController *) animator;

- (void)registerGestureto:(UIViewController *)toVC;

@end
