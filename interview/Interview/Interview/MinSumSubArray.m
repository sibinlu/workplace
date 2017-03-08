//
//  MinSumSubArray.m
//  Interview
//
//  Created by Sibin Lu on 2017/2/16.
//  Copyright © 2017年 sibinlu. All rights reserved.
//

#import "MinSumSubArray.h"

@implementation MinSumSubArray

//Problem: We have an array of Integar. Find out the subArray with the minimum sum.
+(NSArray*)MinSumSubArrayInArray:(NSArray*) numbers;{
    //Induction
    /*Given we have: End(n-1) the minimun sum subarray that ends with the n-1 Object (numbers[n-1]);
     All(n-1) the minimun sum subarray which we want at last.
     Then: End(n) = min(End(n-1)+numbers[n], numbers[n])
     All(n) = min(All(n-1),End(n-1)+numbers[n],numbers[n]) = min(All(n-1),End(n))
    */
    
    if (numbers.count<=0) return nil;
    
    NSInteger sumEndSubArray = [[numbers objectAtIndex:0] integerValue];
    NSUInteger sumEndSubArrayStartIndex=0,sumEndSubArrayEndIndex=0;
    NSInteger sumAllSubArray = [[numbers objectAtIndex:0] integerValue];
    NSUInteger sumAllSubArrayStartIndex=0,sumAllSubArrayEndIndex=0;
    
    for (int i=1; i<numbers.count; i++) {
        NSInteger currentNumber = [[numbers objectAtIndex:i] integerValue];  //numbers[n]
        
        //Update End(n)
        if (currentNumber <= sumEndSubArray + currentNumber) { // End(n) = min(End(n-1)+numbers[n], numbers[n])
            sumEndSubArray = currentNumber;  //End(n)=numbers[n]
            sumEndSubArrayStartIndex = i;
            sumEndSubArrayEndIndex = i;
        }
        else{
            sumEndSubArray = sumEndSubArray + currentNumber; //End(n)=numbers[n]+ End(n-1)
            sumEndSubArrayEndIndex ++;
        }
        
        //Update All(n)
        if (sumEndSubArray<=sumAllSubArray) { //All(n) = min(All(n-1),End(n))
            sumAllSubArray = sumEndSubArray;  //All(n) = End(n)
            sumAllSubArrayStartIndex = sumEndSubArrayStartIndex;
            sumAllSubArrayEndIndex = sumEndSubArrayEndIndex;
        }
        //else All(n) = All(n-1)
    }
    
    NSArray* resultArray = [numbers subarrayWithRange:NSMakeRange(sumAllSubArrayStartIndex, sumAllSubArrayEndIndex - sumAllSubArrayStartIndex +1)];
    return resultArray;
    
}

@end
