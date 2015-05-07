//
//  WSIDTask.h
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSIDResult : NSObject
@property (strong,nonatomic) NSString* result;
@property (nonatomic) BOOL isCorrect;
@end


@interface WSIDTask : NSObject
@property (strong,nonatomic) NSString* taskName;
@property (nonatomic) int taskFrequncy;
@property (nonatomic) int countTotal;
@property (nonatomic) int countFinished;

@property (strong,nonatomic) NSArray* questions;
@property (strong,nonatomic) NSArray* answers;

@property int finishToday;
@property int finishThisWeek;

-(id)initWithName:(NSString*) name;
-(WSIDResult*) checkAnswer:(NSString*) answer atIndex:(int) index;
-(void) finish;

-(NSString *)description;
-(void)save;

@end
