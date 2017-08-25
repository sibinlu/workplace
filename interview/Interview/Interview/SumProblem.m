//
//  SumProblem.m
//  Interview
//
//  Created by Sibin Lu on 2017/3/22.
//  Copyright © 2017年 sibinlu. All rights reserved.
//

#import "SumProblem.h"

@implementation SumProblem
- (NSArray*) twoSumInArray:(NSArray*) array int:(int)target;{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    for(int i = 0;i<array.count;i++){
        int number = [[array objectAtIndex:i] intValue];
        NSString* key = [NSString stringWithFormat:@"%d", target - number];
        NSNumber* partner = [dict objectForKey:key];
        if(partner)
        {
            return [NSArray arrayWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:[partner intValue]],nil];
        }
        else{
            [dict setObject:[NSNumber numberWithInt:i] forKey:[NSString stringWithFormat:@"%d", number]];
        }
    }
    
    return nil;
}

// for sorted array
int* twoSum(int* numbers, int numbersSize, int target, int* returnSize) {
    int head = 0;
    int rear = numbersSize -1;
    while(rear>head){
        int sum = numbers[head] + numbers[rear];
        if (sum == target){
            int* result = malloc(2*sizeof(int));
            result[0] = head+1;
            result[1] = rear +1;
            *returnSize =2;
            return result;
        }
        else if (sum < target){
            head++;
        }
        else if (sum > target){
            rear--;
        }
    }
    return NULL;
}
@end
