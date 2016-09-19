//
//  IVGCD.m
//  Interview
//
//  Created by sibinlu on 16/9/13.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import "IVGCD.h"

@implementation IVGCD
+(void)testDispatchOnce{
    static dispatch_once_t token ;
    for (int i =0 ; i<3; i++) {
        dispatch_once(&token, ^{
            NSLog(@"start %d",i);
            [NSThread sleepForTimeInterval:5];
            NSLog(@"end %d",i);
        });
    }
}

+(void)testDispatchAfter{
    NSLog(@"start ");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Doing");
    });
    NSLog(@"end ");
    
    [NSThread sleepForTimeInterval:20];
}

+(void)testDispatchAsync{
    
    dispatch_queue_t queue = dispatch_queue_create("q1", DISPATCH_QUEUE_CONCURRENT);
    //dispatch_queue_t dqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"1");
    });
    NSLog(@"11");
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"2");
    });
    NSLog(@"22");
    
//    dispatch_notify(<#object#>, <#queue#>, <#notification_block#>)
//    dispatch_group_no
    [NSThread sleepForTimeInterval:20];
    //dispatch_release(queue);
    
}

@end
