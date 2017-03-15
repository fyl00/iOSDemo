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
    
+ (void)barrier {
    
    dispatch_queue_t queue = dispatch_queue_create("me.slowwalker.barrierQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"A START");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"A FINISH");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"B START");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"B FINISH");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"C -> AFTER A&B");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"D -> AFTER A&B");
    });
    
}

+ (void)semaphore {
    
    dispatch_queue_t queue = dispatch_queue_create("me.slowwalker.semaphoreQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"A START");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"A FINISH");
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"semaphore");
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"B START");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"B FINISH");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"C -> AFTER A&B");
        dispatch_semaphore_signal(semaphore);
    });
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
