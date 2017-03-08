//
//  ExcelManagr.m
//  Interview
//
//  Created by Sibin Lu on 2017/3/7.
//  Copyright © 2017年 sibinlu. All rights reserved.
//

#import "ExcelManager.h"

/*
 
 A  B  C
 1 5  10
 2       =A1+B1
 3
 
 
 Only numbers or simple equations
 Equations are only addition on other cells, for example:
 =A1+B1+C1
 =D2+F3
 
 set_cell("A1", 5)
 set_cell("B1", 10)
 set_cell("C2", "=A1+B1")
 
 "=A1+B1"
 
 get_value("A1") -> 5
 get_value("B1") -> 10
 get_value("C2") -> 15
 assume Dictionary for memory
 
 get_cell
 set_cell
 get_cell
 set_cell
 
 The get_cell and set_cell calls may be mixed together. Is there any issue with this approach? I think there are some sequences of calls that will result in breaking the contract of our functions.
 
 set_cell("A1", 5)
 set_cell("B1", 10)
 set_cell("C2", "=A1+B1")
 set_cell("A1", 6)
 
 get_value("C2") -> 6+10?
 
 set_cell("C2", "=C1+A1")
 set_cell("C1", "=C2+A1")
 get_value("C2")
 
 */

@interface ExcelManager ()
@property (nonatomic, strong) NSMutableDictionary* data;
@end

@implementation ExcelManager

-(id) init{
    self = [super init];
    if(self)
    {
        _data = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) setCell:(NSString*) key withNumber:(NSNumber*) number{
    if (!key ) return;
    [self.data setObject:number forKey:key];
}

// set 0 if the equation is invalid
- (void) setCell:(NSString*) key withEquations:(NSString*) equation{
    if (!key || [key isEqualTo:@""]) return;
    [self.data setObject:equation forKey:key];
    
}

-(NSNumber*) numbersFromEquation:(NSString*)equation{
    if(![equation hasPrefix:@"="]) return [NSNumber numberWithInt:0];
    
    NSString* addition = [equation substringWithRange:NSMakeRange(1,equation.length -1)];
    NSArray* cellKeys = [addition componentsSeparatedByString:@"+"];
    
    int sum = 0;
    for(int i=0;i<cellKeys.count;i++){
        NSString* key = [cellKeys objectAtIndex:i];
        NSObject* object = [self.data objectForKey: key];
        NSNumber* number = [self getNumberFrom:object];
        sum += [number intValue];
    }
    return [NSNumber numberWithInt:sum];
}

- (NSNumber*) getNumberFrom:(NSObject*) obj{
    if( [obj isKindOfClass:[NSNumber class]]){
        // it is a number
        return (NSNumber *)obj;
    }
    else if ( [obj isKindOfClass:[NSString class]]){
        // it is a equation
        return [self numbersFromEquation: (NSString*) obj];
        
    }
    return [NSNumber numberWithInt:0];
}

- (NSNumber*) getCell:(NSString*) key{
    NSObject* result = [self.data objectForKey:key];
    
    if (result ) {
        return [self getNumberFrom: result];
    }
    else return [NSNumber numberWithInt:0];
}

@end
