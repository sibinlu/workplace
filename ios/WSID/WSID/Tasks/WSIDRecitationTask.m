//
//  WSIDRecitationTask.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDRecitationTask.h"

@implementation WSIDRecitationTask

//dismiss or
-(NSInteger)indexOfString:(NSString*)str inArray:(NSArray*) array{
    static NSArray* ignores = nil;
    if (!ignores) {
        ignores = [NSArray arrayWithObjects:@"‘",@"’",@"'", nil];
    }
    
    NSInteger index = NSNotFound;
    for (int i=0; i<array.count; i++) {
        NSString* tempStr = [array objectAtIndex:i];
        if ([tempStr isEqualToString:str]) {
            index = i;
            break;
        }
        
        if ([tempStr length] == [str length]) {
            NSString* ntempStr = tempStr;
            NSString* nStr = str;
            for (NSString* ignore in ignores) {
                ntempStr = [ntempStr stringByReplacingOccurrencesOfString:ignore withString:@""];
                nStr = [nStr stringByReplacingOccurrencesOfString:ignore withString:@""];
            }
            if ([ntempStr isEqualToString:nStr]) {
                index = i;
                break;
            }
        }
    }
    
    return index;
}

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
        //NSInteger index = [array_a indexOfObject:a];
        NSInteger index = [self indexOfString:a inArray:array_a];
        if (index == NSNotFound) {
            [miss addObject:a];
        }
    }
    
    for (NSString* a in array_a) {
        if ([a isEqualToString:@""]) {
            continue;
        }
        //NSInteger index = [array_oa indexOfObject:a];
        NSInteger index = [self indexOfString:a inArray:array_oa];
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
