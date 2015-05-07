//
//  WSIDTask.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDTask.h"
#import "WSIDTaskManager.h"

@implementation WSIDResult
@end

@implementation WSIDTask
-(id)initWithName:(NSString*) name;
{
    self = [super init];
    if (self) {
        self.taskName = name;
        NSArray* array = [WSIDTaskManager readArrayFromFile:self.taskName];
        self.taskFrequncy = [[array objectAtIndex:1] intValue];
        self.countTotal = [[array objectAtIndex:2] intValue];
        self.countFinished = [[array objectAtIndex:3] intValue];
        self.finishToday = [[array objectAtIndex:4] intValue];
        self.finishThisWeek = [[array objectAtIndex:5] intValue];
        NSMutableArray *qs = [NSMutableArray array];
        NSMutableArray *as = [NSMutableArray array];
        for (int i = 6; i<array.count; i+=2) {
            NSString* q = [array objectAtIndex:i];
            NSString* a = [array objectAtIndex:i+1];
            [qs addObject:q];
            [as addObject:a];
        }
        self.questions = qs;
        self.answers = as;
    }
    return self;
}
-(WSIDResult*) checkAnswer:(NSString*) answer atIndex:(int) index;
{
    WSIDResult* r = [[WSIDResult alloc] init];
    r.result = @"Correct";
    r.isCorrect = YES;
    
    return r;
}
-(void) finish;
{
    if (self.countTotal >0 && self.countTotal > self.countFinished) {
        self.countFinished ++;
        if (self.finishToday != 1) {
            self.finishToday =1;
            self.finishThisWeek ++;
        }
        [self save];
    }
}

-(NSString *)description;
{
    NSMutableString* d = [[NSMutableString alloc] init];
    [d appendFormat:@"%@\t%d\t%d\t%d\t%d\t%d",self.taskName,self.taskFrequncy,self.countTotal,self.countFinished,self.finishToday,self.finishThisWeek];
    for (int i = 0; i<self.questions.count && i<self.answers.count; i++) {
        NSString* q = [self.questions objectAtIndex:i];
        NSString* a = [self.answers objectAtIndex:i];
        [d appendFormat:@"\t%@\t%@",q,a];
    }
    return d;
}

-(void)save;
{
    [WSIDTaskManager writeStringToFile:self.taskName content:[self description]];
}
@end
