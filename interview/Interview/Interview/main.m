//
//  main.m
//  Interview
//
//  Created by sibinlu on 16/8/17.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVBinaryTreeTest.h"
#import "IVGCD.h"
#import "IVRecursionProblems.h"
#import "LockAndSeeSequence.h"
#import "MinSumSubArray.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        //[IVBinaryTreeTest Test1];
        //[IVGCD testDispatchAsync];
        
//        LockAndSeeSequence* s = [[LockAndSeeSequence alloc] init];
//        NSString* result = [s nthLookAndSayNumber:5];
//        NSLog(@"%@",result);
        [MinSumSubArray MinSumSubArrayInArray:[NSArray arrayWithObject:[NSNumber numberWithInteger:100]]];
        //[MinSumSubArray MinSumSubArrayInArray:[NSArray arrayWithObjects:[NSNumber numberWithInteger:-100],[NSNumber numberWithInteger:200],[NSNumber numberWithInteger:-3],[NSNumber numberWithInteger:-5],[NSNumber numberWithInteger:3],[NSNumber numberWithInteger:-1],nil]];
    }
    return 0;
}
