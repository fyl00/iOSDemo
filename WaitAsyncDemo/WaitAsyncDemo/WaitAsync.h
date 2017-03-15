//
//  WaitAsync.h
//  WaitAsyncDemo
//
//  Created by SlowWalker on 13/03/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaitAsync : NSObject

+ (void)default;
+ (void)barrier;
+ (void)semaphore;
+ (void)group;

@end
