//
//  WSIDRecitationTask.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDRecitationTask.h"

@implementation WSIDRecitationTask
-(WSIDResult*) checkAnswer:(NSString*) answer atIndex:(int) index;
{
    NSString* oa = [self.answers objectAtIndex:index];
    
    NSArray* array_oa =[oa componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray* array_a = [answer componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSMutableArray* miss = [NSMutableArray array];
    NSMutableArray* notfound = [NSMutableArray array];
    
    for (NSString* a in array_oa) {
        if ([a isEqualToString:@""]) {
            continue;
        }
        NSInteger index = [array_a indexOfObject:a];
        if (index == NSNotFound) {
            [miss addObject:a];
        }
    }
    
    for (NSString* a in array_a) {
        if ([a isEqualToString:@""]) {
            continue;
        }
        NSInteger index = [array_oa indexOfObject:a];
        if (index == NSNotFound) {
            [notfound addObject:a];
        }
    }
    
    WSIDResult* r = [[WSIDResult alloc] init];
    NSMutableString* result = [NSMutableString stringWithString:@""];
    
    if (miss.count !=0 ) {
        [result appendFormat:@"MISS:      %@",[miss componentsJoinedByString:@" "] ];
        [result appendString:@"\r\n"];
    }
    if (notfound.count !=0 ) {
        [result appendFormat:@"NOTFOUND:   %@",[notfound componentsJoinedByString:@" "] ];
        [result appendString:@"\r\n"];
    }
    if ([result isEqualToString:@""]) {
        r.result = @"Correct";
        r.isCorrect = YES;
    }
    else{
        r.result = result;
        r.isCorrect = NO;
    }
    return r;
}
@end
