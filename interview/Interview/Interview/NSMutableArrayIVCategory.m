//
//  NSMutableArrayIVCategory.m
//  Interview
//
//  Created by sibinlu on 16/8/18.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import "NSMutableArrayIVCategory.h"

@implementation NSMutableArray (IVCategory)

-(void)quicksort;{
    [self quicksortFromStart:0 end:self.count-1];
}
-(void)quicksortFromStart:(NSInteger)start end:(NSInteger)end;{
    if (start<end){
        NSInteger partition = [self partitionFromStart:start end:end];
        [self quicksortFromStart:start end:partition-1];
        [self quicksortFromStart:partition+1 end:end];
    }
}

-(NSInteger)partitionFromStart:(NSInteger)start end:(NSInteger)end;{
    if (start<end){
        NSString* temp = [self objectAtIndex:end];
        NSUInteger i = start, j = start;
        for (j = start; j<= end -1; j++)
        {
            NSString* str = [self objectAtIndex:j];
            if ([str compare:temp]==NSOrderedAscending) {
                [self exchangeObjectAtIndex:i withObjectAtIndex:j];
                i++;
            }
        }
        [self exchangeObjectAtIndex:end withObjectAtIndex:i];
        return i;
    }
    return -1;
}

@end
