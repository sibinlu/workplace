//
//  IVRecursionProblems.h
//  Interview
//
//  Created by Sibin Lu on 2017/1/10.
//  Copyright © 2017年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IVRecursionProblems : NSObject

@end

@interface IVRecursionProblemNumbersToChars : NSObject
@property (nonatomic,strong) NSDictionary* dict;
-(void) printAllStringsFromNumbers:(NSString*) nums;
@end
