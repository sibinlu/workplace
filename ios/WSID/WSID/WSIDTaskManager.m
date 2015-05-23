//
//  WSIDTaskManager.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDTaskManager.h"

@implementation WSIDTaskManager

static WSIDTaskManager * mgr;

+ (WSIDTaskManager*) manager;{
    if (!mgr) {
        mgr = [[WSIDTaskManager alloc] init];
        [mgr reload];
    }
    return mgr;
}

- (WSIDTask*) nextManager;{
    if (self.tasks && self.tasks.count >0) {
        return [self.tasks objectAtIndex:0];
    }
    return nil;
}
- (void) reload;
{
    self.tasks = [NSMutableArray array];
    NSArray* array = [WSIDTaskManager readArrayFromFile:@"tm"];
    int last = [[array objectAtIndex:0] intValue];
    _lastUpdate = last;
    for (int i =1; i<array.count; i+=2) {
        NSString* class = [array objectAtIndex:i];
        NSString* file = [array objectAtIndex:i+1];
        
        WSIDTask* task = nil;
        
        if ([class isEqualToString:NSStringFromClass([WSIDRecitationTask class])]) {
            task =[[WSIDRecitationTask alloc] initWithName:file];
        }else if ([class isEqualToString:NSStringFromClass([WSIDLearningTask class])]) {
            task =[[WSIDLearningTask alloc] initWithName:file];
        }else if ([class isEqualToString:NSStringFromClass([WSIDDictionaryTask class])]) {
            task =[[WSIDDictionaryTask alloc] initWithName:file];
        }
        [self.tasks addObject:task];
    }
    [self checkUpdate];
}

-(void)checkUpdate{
    
    int now = [[NSDate date] timeIntervalSince1970];
    BOOL aNewDay = [self isANewDayLast:_lastUpdate now:now];
    BOOL aNewWeek = [self isANewWeekLast:_lastUpdate now:now];
    for (WSIDTask* task in self.tasks) {
        if (task) {
            if (aNewDay) {
                task.finishToday = 0;
            }
            if (aNewWeek) {
                task.finishThisWeek = 0;
            }
            
        }
    }
    if (aNewDay|| aNewWeek) {
        _lastUpdate = now;
        [self save];
    }
}

- (void) save;{
    NSMutableString* tm = [[NSMutableString alloc] init];
    int ts = _lastUpdate;
    [tm appendFormat:@"%d",ts];
    for (WSIDTask* task in self.tasks) {
        [task save];
        [tm appendFormat:@"\t%@\t%@",NSStringFromClass([task class]), task.taskName ];
    }
    [WSIDTaskManager writeStringToFile:@"tm" content:tm];
}

-(void)finishTask:(WSIDTask *)task{
    [self checkUpdate];
    //_lastUpdate = [[NSDate date] timeIntervalSince1970];
    [task finish];
}


//helpers
+(NSString*) readStringFromFile:(NSString*) file;
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:file];
    if ( ![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];

    }
    NSString* myString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    return myString;
}
+(NSArray*) readArrayFromFile:(NSString*) file;
{
    NSString* str = [WSIDTaskManager readStringFromFile:file];
    NSArray* array = [str componentsSeparatedByString:@"\t"];
    return array;
}
+(BOOL) writeStringToFile:(NSString*) file content:(NSString*)str;
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:file];
    if ( ![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        
    }
    return [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}


//GMT 2015-5-3 00:00 Sun
#define BasicTS 1430611200
-(BOOL) isANewDayLast:(int) last now:(int) now{
    int interval = 24*60*60;
    return (last-BasicTS)/interval != (now-BasicTS)/interval;
}
-(BOOL) isANewWeekLast:(int) last now:(int) now{
    int interval = 7*24*60*60;
    return (last-BasicTS)/interval != (now-BasicTS)/interval;
}

- (WSIDTask*) nextToDo;{
    WSIDTask* nextTask = nil;
    int value = 0;
    for (WSIDTask* task in self.tasks) {
        if (task.countFinished >= task.countTotal)continue;
        if (task.finishThisWeek >= task.taskFrequncy)continue;
        if (task.finishToday)continue;
        if (task.taskFrequncy - task.finishThisWeek >value) {
            value =task.taskFrequncy - task.finishThisWeek;
            nextTask = task;
        }
    }
    return nextTask;
}

@end
