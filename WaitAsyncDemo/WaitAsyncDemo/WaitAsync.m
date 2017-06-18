//
//  WaitAsync.m
//  WaitAsyncDemo
//
//  Created by SlowWalker on 13/03/2017.
//  Copyright © 2017 slowwalker.me. All rights reserved.
//

#import "WaitAsync.h"

@implementation WaitAsync

    
+ (void)default {
    
    dispatch_queue_t queue = dispatch_queue_create("me.slowwalker.defaultQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"A START");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"A FINISH");
    });
    dispatch_async(queue, ^{
        NSLog(@"B START");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"B FINISH");
    });
    dispatch_async(queue, ^{
        NSLog(@"C -> AFTER A&B");
    });
    
}
    
+ (void)semaphore {
    
    dispatch_queue_t queueA = dispatch_queue_create("me.slowwalker.semaphoreQueueA", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queueB = dispatch_queue_create("me.slowwalker.semaphoreQueueB", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(queueA, ^{
        NSLog(@"QueueA START");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"QueueA FINISH");
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"semaphore");
    dispatch_async(queueB, ^{
        NSLog(@"QueueB START");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"QueueB FINISH");
        dispatch_semaphore_signal(semaphore);
    });

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"C -> AFTER A&B");

}
    
+ (void)group {
    dispatch_queue_t queue = dispatch_queue_create("me.slowwalker.groupQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
//    dispatch_group_enter(group);
//    dispatch_async(queue, ^{
//        NSLog(@"A START");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"A FINISH");
//        dispatch_group_leave(group);
//    });
//    
//    dispatch_group_enter(group);
//    dispatch_async(queue, ^{
//        NSLog(@"B Start");
//        [NSThread sleepForTimeInterval:1];
//        NSLog(@"B Finish");
//        dispatch_group_leave(group);
//    });
    
    // Another
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"A START");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"A FINISH");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"B Start");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"B Finish");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"C - AFTER A&B(Into main queue)");
    });
    
}

    
@end
