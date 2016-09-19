//
//  IVGCD.h
//  Interview
//
//  Created by sibinlu on 16/9/13.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IVGCD : NSObject
@property (nonatomic,retain) dispatch_queue_t aqueue;
+(void)testDispatchOnce;
+(void)testDispatchAfter;
+(void)testDispatchAsync;
@end
