//
//  LockAndSeeSequence.m
//  Interview
//
//  Created by Sibin Lu on 2017/1/17.
//  Copyright © 2017年 sibinlu. All rights reserved.
//

#import "LockAndSeeSequence.h"

@implementation LockAndSeeSequence

/*
 Look and Say Sequence
 Starts with 1
 Subsequent numbers describe previous number by number of consecutive digits.
 
 Example:
 1 is described as "One 1" so the next number in the sequence is 11
 11 is "Two 1's" so the next is 21
 21 is "One 2 and One 1" so next is 1211
 1211
 111221
 312211
 13112221
 1113213211
 
 Write a function that returns the n'th Look-and-Say number.
 */
//
//
//n = 0 -> 1
//n = 1 -> 11
//n = 2 -> 21
//
//1 -> "One 1" -> 11
//11 -> "Two 1's"
//21 -> "One 2, One 1"
//1211 -> "One 1, One 2, Two 1"
//111221 -> 111 22 1 -> 31 22 11 -> 312211
//312211 -> 13112221
////
//
//Dune by Frank Herbert
//
//Death's End Cixin Liu
//
//// input is 21
//// cn =2 c =1
//// r = 1211

-(NSString*) LookAndSaySequence:(NSString*) input{
    if(!input || input.length == 0) return input;
    
    NSUInteger length = input.length;
    
    NSString* currentNumber = @"";
    int count = 0;
    NSMutableString* result=[NSMutableString stringWithString:@""];
    for(int i =0; i< length ; i++)
    {
        NSString* num = [input substringWithRange:NSMakeRange(i,1)];
        if([num isEqualTo: currentNumber]){
            count++;
        }
        else{
            if (count >0){
                //print to result;
                [result appendFormat:@"%d%@",count,currentNumber];
            }
            currentNumber = num;
            count = 1;
        }
    }
    
    if (count >0){
        //print to result;
        [result appendFormat:@"%d%@",count,currentNumber];
    }
    
    
    return result;
    
}

- (NSString*) nthLookAndSayNumber:(uint) nth{
    NSString* num = @"1";
    for(int i =0 ; i<nth;i++)
    {
        num = [self LookAndSaySequence:num];
    }
    return num;
}

@end
