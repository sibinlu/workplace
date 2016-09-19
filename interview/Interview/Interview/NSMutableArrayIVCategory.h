//
//  NSMutableArrayIVCategory.h
//  Interview
//
//  Created by sibinlu on 16/8/18.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray(IVCategory)

-(void)quicksort;
-(void)quicksortFromStart:(NSInteger)start end:(NSInteger)end;
-(NSInteger)partitionFromStart:(NSInteger)start end:(NSInteger)end;

@end
