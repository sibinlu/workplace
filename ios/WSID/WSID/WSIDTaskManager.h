//
//  WSIDTaskManager.h
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSIDTask.h"
#import "WSIDRecitationTask.h"
#import "WSIDLearningTask.h"
#import "WSIDDictionaryTask.h"
@interface WSIDTaskManager : NSObject
@property (nonatomic,strong) NSMutableArray* tasks;
@property (readonly) int lastUpdate;
@property (readonly) float dataVersion;
+ (WSIDTaskManager*) manager;
- (WSIDTask*) nextManager;
- (void) reload;
- (void) save;
-(void)checkUpdate;
- (void)finishTask:(WSIDTask*) task;
- (WSIDTask*) nextToDo;
//helpers
+(NSString*) readStringFromFile:(NSString*) file;
+(NSArray*) readArrayFromFile:(NSString*) file;
+(BOOL) writeStringToFile:(NSString*) file content:(NSString*)str;
@end
