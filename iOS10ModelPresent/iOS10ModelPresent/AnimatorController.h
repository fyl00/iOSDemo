//
//  AnimationController.h
//  iOS10ModelPresent
//
//  Created by SlowWalker on 18/05/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TransitionType) {
    AnimatorPresent = 1,
    AnimatorDismiss = -1,
};

@interface AnimatorController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) TransitionType transitionType;

- (id)initWithType:(TransitionType)type;

@end
