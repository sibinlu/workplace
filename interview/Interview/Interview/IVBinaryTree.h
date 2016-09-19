//
//  IVBinaryTree.h
//  Interview
//
//  Created by sibinlu on 16/8/17.
//  Copyright © 2016年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IVBinaryTreeNode : NSObject
@property (nonatomic, strong)NSString* value;
@property (nonatomic, strong)IVBinaryTreeNode* leftNode;
@property (nonatomic, strong)IVBinaryTreeNode* rightNode;
-(id) initWithValue:(NSString*) newValue;
-(id) initWithArray:(NSArray*) valueArray;
-(void) addNewValue:(NSString*) newValue;
-(void) print;

@end
