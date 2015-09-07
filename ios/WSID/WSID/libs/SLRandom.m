//
//  SLRandom.m
//  Earpro
//
//  Created by sibinlu on 15/8/11.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "SLRandom.h"

@implementation SLRandom
//min -> max-1
+(NSInteger)numberBetweenMin:(NSInteger)min andMax:(NSInteger)max{
    NSInteger range = max-min;
    NSInteger randomNumber = arc4random() % range;
    return randomNumber+ min;
}
//-(max-1) -> max-1
+(NSInteger)numberAroundZero:(NSInteger)max{
    return [self numberBetweenMin:-(max-1) andMax:max];
}

+(BOOL)boolNumber{
    NSInteger n = [self numberBetweenMin:0 andMax:2];
    if (n == 0) {
        return NO;
    }
    else{
        return YES;
    }
}

+(NSInteger)numberInList:(NSArray*)numbers aroundZero:(BOOL) isAroundZero{
    NSInteger max = numbers.count;
    NSInteger index = [self numberBetweenMin:0 andMax:max];
    NSNumber* n = [numbers objectAtIndex:index ];
    
    if (!isAroundZero) {
        return [n integerValue];
    }
    else{
        if ([self boolNumber]) {
            return -[n integerValue];
        }
        else return [n integerValue];
    }
    
}
@end
