//
//  SLRandom.h
//  Earpro
//
//  Created by sibinlu on 15/8/11.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLRandom : NSObject

+(NSInteger)numberBetweenMin:(NSInteger)min andMax:(NSInteger)max;
+(NSInteger)numberAroundZero:(NSInteger)max;
+(BOOL)boolNumber;
+(NSInteger)numberInList:(NSArray*)numbers aroundZero:(BOOL) isAroundZero;
@end
