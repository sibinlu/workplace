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
#import "DeletionDistance.h"
#import "SumProblem.h"
#import "ValidNumber.h"
//deletion distance between 2 str


@interface Test : NSObject

@end

@implementation Test


@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //SumProblem* p = [[SumProblem alloc] init];
        //NSArray* testArray = @[[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:5],[NSNumber numberWithInt:9]];
        //NSArray* result = [p twoSumInArray:testArray int:11];
        //NSLog(@"%@",result);
        bool b = [ValidNumber validNumber:@"+23e-4"];
        NSLog(@"%d",b);
        NSMutableArray* a = @[@"11",@"22"];
    
        NSString* ss= @"A";
        
        [ss characterAtIndex:0];
        
        NSMutableSet* s = [[NSMutableSet alloc] init];
        //[s addObject:]
        
        
        
    }
    return 0;
}
