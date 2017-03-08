//
//  IVRecursionProblems.m
//  Interview
//
//  Created by Sibin Lu on 2017/1/10.
//  Copyright © 2017年 sibinlu. All rights reserved.
//

#import "IVRecursionProblems.h"

@implementation IVRecursionProblems

@end

@implementation IVRecursionProblemNumbersToChars : NSObject
-(id) init{
    self = [super init];
    if (self) {
        _dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"a",@"b",@"c",nil],@"1",
                 [NSArray arrayWithObjects:@"d",@"e",@"f",nil],@"2",
                 [NSArray arrayWithObjects:@"g",@"h",@"i",nil],@"3",
                 [NSArray arrayWithObjects:@"j",@"k",@"l",nil],@"4",
                 
                 nil];
        
    }
    return self;
}

-(void) printAllStringsFromNumbers:(NSString*) nums
{
    [self printAllStringsFromNumbers:nums fromIndex:0 withPrefix:@""];
    
}


-(void) printAllStringsFromNumbers:(NSString*) nums fromIndex:(NSUInteger) index withPrefix:(NSString*)prefix
{
    if (index >= nums.length) {
        NSLog(@"%@",prefix);
        return;
    }
    
    NSString* key = [nums substringWithRange:NSMakeRange(index, 1)];
    NSArray* values = [self.dict objectForKey:key];
    if (!values) {
        values = [NSArray arrayWithObject:key];
    }
    
    for (NSString* value in values) {
        if (![value isKindOfClass:[NSString class]]) {
            continue;
        }
        NSString* currentPrefix = [NSString stringWithFormat:@"%@%@",prefix,value];
        [self printAllStringsFromNumbers:nums fromIndex:index+1 withPrefix:currentPrefix];
    }
    
}

@end
