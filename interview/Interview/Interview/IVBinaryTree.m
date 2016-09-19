//
//  IVBinaryTree.m
//  Interview
//
//  Created by sibinlu on 16/8/17.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import "IVBinaryTree.h"

@interface IVBinaryTreeNodeWithLevel : NSObject
@property (nonatomic , strong) IVBinaryTreeNode* node;
@property (nonatomic) NSUInteger level;
-(id) initWithNode:(IVBinaryTreeNode*) node level:(NSUInteger)level;
@end

@implementation IVBinaryTreeNodeWithLevel

-(id)initWithNode:(IVBinaryTreeNode *)node level:(NSUInteger)level{
    if (self) {
        self.node = node;
        self.level = level;
    }
    return self;
}

@end

@implementation IVBinaryTreeNode
-(id) initWithValue:(NSString*) newValue;
{
    if (self) {
        self.value = newValue;
    }
    return self;
}
-(id) initWithArray:(NSArray*) valueArray;{
    if (!valueArray || ![valueArray count]) {
        return  nil;
    }
    if (self) {
        self.value = [valueArray objectAtIndex:0];
        self.leftNode = nil;
        self.rightNode = nil;
        for (int i =1; i<[valueArray count]; i++) {
            [self addNewValue:[valueArray objectAtIndex:i]];
        }
    }
    return self;
}
-(void) addNewValue:(NSString*) newValue;{
    if (!newValue) {
        return;
    }

    IVBinaryTreeNode* pivot = self;
    while (pivot.value) {
        NSComparisonResult result = [newValue compare:pivot.value];
        if (result == NSOrderedSame) {
            return;
        }
        else if (result == NSOrderedAscending) {
            if (!pivot.leftNode) {
                pivot.leftNode = [[IVBinaryTreeNode alloc] init];
            }
            pivot = pivot.leftNode;
        }
        else if (result == NSOrderedDescending) {
            if (!pivot.rightNode) {
                pivot.rightNode = [[IVBinaryTreeNode alloc] init];
            }
            pivot = pivot.rightNode;
        }
        
    }
    pivot.value = newValue;
}
-(void) print;{
    void (^block)(IVBinaryTreeNode*) = ^(IVBinaryTreeNode* node){
        NSLog(@"%@",node.value);
    };
    
    
    [self GIPreOrderTranversalNRPrint];
    //[self postOrderTranversal:block];
    NSLog(@"##############################");
    //[self levelOrderTranversalNR:block];
    
    NSLog(@"%lu , %lu",[self leafCount],[self leafCountNR]);
}

#pragma mark - Tranversal Recurring
-(void) preOrderTranversal:(void (^)(IVBinaryTreeNode* node))block;{
    if (!block) return;
    block(self);
    if (self.leftNode) {
        [self.leftNode preOrderTranversal:block];
    }
    if (self.rightNode) {
        [self.rightNode preOrderTranversal:block];
    }
}
-(void) inOrderTranversal:(void (^)(IVBinaryTreeNode* node))block;{
    if (!block) return;
    if (self.leftNode) {
        [self.leftNode inOrderTranversal:block];
    }
    block(self);
    if (self.rightNode) {
        [self.rightNode inOrderTranversal:block];
    }
}
-(void) postOrderTranversal:(void (^)(IVBinaryTreeNode* node))block;{
    if (!block) return;
    if (self.leftNode) {
        [self.leftNode postOrderTranversal:block];
    }
    if (self.rightNode) {
        [self.rightNode postOrderTranversal:block];
    }
    block(self);
}


#pragma mark - Tranversal Non-Recurring
-(void) preOrderTranversalNR:(void (^)(IVBinaryTreeNode* node))block{
    if (!block) return;
    NSMutableArray * stack = [NSMutableArray array];
    IVBinaryTreeNode* root = self;
    while(root || stack.count){
        if (root) {
            block(root);
            [stack insertObject:root atIndex:0];
            root = root.leftNode;
        }
        else{
            root = [stack objectAtIndex:0];
            [stack removeObjectAtIndex:0];
            root = root.rightNode;
        }
    }
}


-(void) inOrderTranversalNR:(void (^)(IVBinaryTreeNode* node))block{
    if (!block) return;
    NSMutableArray* stack = [NSMutableArray array];
    IVBinaryTreeNode* root = self;
    while (root || stack.count) {
        if (root) {
            [stack insertObject:root atIndex:0];
            root = root.leftNode;
        }
        else{
            root = [stack objectAtIndex:0];
            block(root);
            [stack removeObjectAtIndex:0];
            root = root.rightNode;
        }
    }
    
}

-(void) postOrderTranversalNR:(void (^)(IVBinaryTreeNode* node))block{
    if (!block) return;
    
    NSMutableArray* stack = [NSMutableArray array];
    NSMutableArray* output = [NSMutableArray array];
    [stack addObject:self];
    while(stack.count){
        IVBinaryTreeNode* root = [stack objectAtIndex:0];
        [output insertObject:root atIndex:0];
        [stack removeObjectAtIndex:0];
        
        if (root.leftNode){
            [stack insertObject:root.leftNode atIndex:0];
        }
        if (root.rightNode){
            [stack insertObject:root.rightNode atIndex:0];
        }
    }
    
    for (IVBinaryTreeNode* item in output) {
        block(item);
    }
}


-(void) levelOrderTranversalNR:(void (^)(IVBinaryTreeNode* node))block{
    if (!block) return;
    NSMutableArray* stack = [NSMutableArray arrayWithObject:self];
    while(stack.count)
    {
        IVBinaryTreeNode* root = [stack objectAtIndex:0];
        block(root);
        [stack removeObjectAtIndex:0];
        if (root.leftNode) {
            [stack addObject:root.leftNode];
        }
        if (root.rightNode) {
            [stack addObject:root.rightNode];
        }
    }
    
}
-(void)GIPreOrderTranversalNRPrint{
    
    void (^block)(IVBinaryTreeNode* , NSUInteger ) = ^(IVBinaryTreeNode* node, NSUInteger level){
        NSMutableString* line = [NSMutableString string];
        for (int i =0 ; i<level; i++) {
            [line appendString:@" |  "];
        }
        [line appendFormat:@"%@",node.value ];
        NSLog(@"%@",line);
    };
    
    //[self GIPreOrderTranversalNR:block];
    
    [self GIPreOrderTranversal:block startLevel:0];
}


-(void)GIPreOrderTranversal:(void (^)(IVBinaryTreeNode* node, NSUInteger level))block startLevel:(NSUInteger) startLevel{
    if (!block) return;
    block(self,startLevel);
    if (self.leftNode){
        [self.leftNode GIPreOrderTranversal:block startLevel:startLevel+1];
    }
    if (self.rightNode){
        [self.rightNode GIPreOrderTranversal:block startLevel:startLevel+1];
    }
}

-(void)GIPreOrderTranversalNR:(void (^)(IVBinaryTreeNode* node, NSUInteger level))block{
    if (!block) return;
    NSMutableArray* stack = [NSMutableArray array];
    IVBinaryTreeNodeWithLevel* root = [[IVBinaryTreeNodeWithLevel alloc] initWithNode:self level:0];
    [stack addObject:root];
    while (stack.count){
        root = [stack objectAtIndex:0];
        [stack removeObjectAtIndex:0];
        block(root.node,root.level);
        if (root.node.rightNode) {
            IVBinaryTreeNodeWithLevel* right = [[IVBinaryTreeNodeWithLevel alloc] initWithNode:root.node.rightNode level:root.level+1];
            [stack insertObject:right atIndex:0];
        }
        if (root.node.leftNode) {
            IVBinaryTreeNodeWithLevel* left = [[IVBinaryTreeNodeWithLevel alloc] initWithNode:root.node.leftNode level:root.level+1];
            [stack insertObject:left atIndex:0];
        }
    }
}

#pragma mark - Attribute
-(NSUInteger)nodeCount{
    NSUInteger leftTreeNodeCount =0, rightTreeNodeCount =0;
    if (self.leftNode){
        leftTreeNodeCount = [self.leftNode nodeCount];
    }
    if (self.rightNode){
        rightTreeNodeCount = [self.rightNode nodeCount];
    }
    return leftTreeNodeCount + rightTreeNodeCount +1;
}

-(NSUInteger)nodeCountNR{
    NSMutableArray* stack = [NSMutableArray arrayWithObject:self];
    int count = 0;
    while (stack.count){
        IVBinaryTreeNode* root = [stack objectAtIndex:0];
        count ++;
        [stack removeObjectAtIndex:0];
        if(root.leftNode)[stack addObject:root.leftNode];
        if(root.rightNode)[stack addObject:root.rightNode];
    }
    return count;
}


-(NSUInteger)levelCount{
    NSUInteger leftTreeLevelCount =0 , rightTreeLevelCount = 0;
    if(self.leftNode){
        leftTreeLevelCount = [self.leftNode levelCount];
    }
    
    if(self.rightNode){
        rightTreeLevelCount = [self.rightNode levelCount];
    }
    return MAX(leftTreeLevelCount, rightTreeLevelCount) +1;
}

-(NSUInteger)levelCountNR{
    NSMutableArray* currentLevel = [NSMutableArray arrayWithObject:self];
    NSMutableArray* nextLevel = [NSMutableArray array];
    NSUInteger levelCount =0;
    while(currentLevel.count){
        levelCount++;
        for (IVBinaryTreeNode* node in currentLevel) {
            if (node.leftNode) [nextLevel addObject:node.leftNode];
            if (node.rightNode) [nextLevel addObject:node.rightNode];
        }
        //swap
        currentLevel = nextLevel;
        nextLevel = [NSMutableArray array];
    }
    return levelCount;
}

-(NSUInteger) nodeCountOnLevel:(NSUInteger)level{
    if (level == 0 ) return 1;
    NSUInteger leftTreeNodeCountOnLevel = 0;
    NSUInteger rightTreeNodeCountOnLevel = 0;
    if (self.leftNode) {
        leftTreeNodeCountOnLevel = [self.leftNode nodeCountOnLevel:level-1];
    }
    if (self.rightNode) {
        rightTreeNodeCountOnLevel = [self.rightNode nodeCountOnLevel:level-1];
    }
    
    return leftTreeNodeCountOnLevel + rightTreeNodeCountOnLevel;
}

-(NSUInteger) nodeCountOnLevelNR:(NSUInteger)level{
    NSMutableArray *currentLevel = [NSMutableArray arrayWithObject:self];
    NSMutableArray *nextLevel = [NSMutableArray array];
    while (currentLevel.count) {
        if (level == 0) return currentLevel.count;
        
        for (IVBinaryTreeNode* node in currentLevel) {
            if (node.leftNode) [nextLevel addObject:node.leftNode];
            if (node.rightNode) [nextLevel addObject:node.rightNode];
        }
        
        //swap
        currentLevel = nextLevel;
        nextLevel = [NSMutableArray array];
        level --;
    }
    return 0;
}


-(NSUInteger) leafCount{
    NSUInteger leftTreeLeafCount =0;
    NSUInteger rightTreeLeafCount =0;
    if (!self.leftNode && !self.rightNode) {
        return 1;
    }
    if (self.leftNode) {
        leftTreeLeafCount = [self.leftNode leafCount];
    }
    if (self.rightNode) {
        rightTreeLeafCount = [self.rightNode leafCount];
    }
    return leftTreeLeafCount + rightTreeLeafCount;
}

-(NSUInteger) leafCountNR{
    NSMutableArray* array = [NSMutableArray arrayWithObject:self];
    int leafCount = 0;
    while(array.count){
        IVBinaryTreeNode* root = [array objectAtIndex:0];
        [array removeObjectAtIndex:0];
        if (!root.leftNode && !root.rightNode) {
            leafCount++;
        }
        if (root.leftNode) {
            [array addObject:root.leftNode];
        }
        if (root.rightNode) {
            [array addObject:root.rightNode];
        }
    }
    return leafCount;
}
@end
