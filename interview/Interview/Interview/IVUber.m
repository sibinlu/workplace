//
//  IVUber.m
//  Interview
//
//  Created by Sibin Lu on 2017/1/11.
//  Copyright © 2017年 sibinlu. All rights reserved.
//

#import "IVUber.h"

@implementation IVUber

@end

/** UBNotificationCenter.h */

typedef void (^Observer)(NSString *name, id data);

@interface UBNotificationCenter : NSObject

- (void)addObserverForName:(NSString *)name block:(Observer)block;
- (void)removeObserverForName:(NSString *)name block:(Observer)block;
- (void)postNotification:(NSString *)name data:(id)data;

@end

/** UBNotificationCenter.m */

@interface UBNotificationCenter ()
@property (nonatomic, strong) NSMutableDictionary* notifications;
@end

@implementation UBNotificationCenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _notifications = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addObserverForName:(NSString *)name block:(Observer)block
{
    if (!block){
        return;
    }
    NSMutableArray* blocks = [self.notifications objectForKey: name];
    if (!blocks){
        blocks = [[NSMutableArray alloc] init];
    }
    
    [blocks addObject:block];
    //NSString* key =hash(block)
    [self.notifications setObject:blocks forKey:name];
}

- (void)removeObserverForName:(NSString *)name block:(Observer)block
{
    if (!block){
        return;
    }
    
    NSMutableArray* blocks = [self.notifications objectForKey: name];
    if (!blocks){
        return;
    }
    
    //Need test ;if equal works
    [blocks removeObject:block];
    
    if(blocks.count == 0){
        [self.notifications removeObjectForKey:name];
    }
    
}

- (void)postNotification:(NSString *)name data:(id)data
{
    NSMutableArray* blocks = [self.notifications objectForKey: name];
    if (!blocks){
        return;
    }
    
    for(Observer block in blocks){
        block (name,data);
    }
}

@end


@interface UnitTest : NSObject
+(void) testUBNotificationCenter;
@end

@implementation UnitTest
+(void) testUBNotificationCenter;{
    UBNotificationCenter *center = [[UBNotificationCenter alloc] init];
    void (^block)(NSString *name, id data) = ^(NSString *name, id data){
        //do sth;
        NSLog(@"1");
    };
    void (^block2)(NSString *name, id data) = ^(NSString *name, id data){
        //do sth;
        NSLog(@"2");
    };
    [center addObserverForName:@"test" block:block];
    [center addObserverForName:@"test" block:block2];
    [center postNotification:@"test" data:[NSNumber numberWithInt:1]];
    [center removeObserverForName:@"test" block:block2];
    [center postNotification:@"test" data:[NSNumber numberWithInt:1]];
}
@end


//int main (int argc, const char * argv[])
//{
//    NSLog(@"start");
//    //UBNotificationCenter *center = [[UBNotificationCenter alloc] init];
//    [UnitTest testUBNotificationCenter];
//    NSLog(@"end");
//}
