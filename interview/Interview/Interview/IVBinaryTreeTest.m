//
//  IVBinaryTreeTest.m
//  Interview
//
//  Created by sibinlu on 16/8/17.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import "IVBinaryTreeTest.h"
#import "IVBinaryTree.h"
#import "NSMutableArrayIVCategory.h"


@implementation IVBinaryTreeTest
+(void)Test1{
    NSLog(@"TEst1");
    
    NSString* letter = @"Red Apples Blood Oranges Cherries Cranberries Red Grapes Pink/Red Grapefruit Red Pears Pomegranates Raspberries Strawberries Watermelon Partition";
    
    NSArray* array = [letter componentsSeparatedByString:@" "];
    
//    IVBinaryTreeNode* testTree = [[IVBinaryTreeNode alloc] initWithArray:array];
//    [testTree print];
    
    NSMutableArray* array2 = [NSMutableArray arrayWithArray:array];
    
    for (NSString* str in array2) {
        NSLog(@"%@", str);
    }
    NSLog(@"#########################");
//    NSUInteger index = [array2 partitionFromStart:0 end:array2.count-1];
//    NSLog(@"%lu",index);
    [array2 quicksort];
    for (NSString* str in array2) {
        NSLog(@"%@", str);
    }
}

@end
