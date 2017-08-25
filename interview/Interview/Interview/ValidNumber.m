//
//  ValidNumber.m
//  Interview
//
//  Created by Sibin Lu on 2017/3/22.
//  Copyright © 2017年 sibinlu. All rights reserved.
//

#import "ValidNumber.h"

@implementation ValidNumber

#define number(_i) [NSNumber numberWithInt:_i]
#define charAtIndex(_s,_i) [_s substringWithRange:NSMakeRange(_i, 1)]
+ (BOOL) validNumber:(NSString*) str{
    //DFA
    int end=8,e=5;
    NSArray* dfa = @[@{ @" ":number(0) , @"digit":number(1) ,@"sign":number(2),@".":number(3) },  //0
                     @{ @" ":number(end),@"digit":number(1),@".":number(3) ,@"e":number(e) },  //1  valid
                     @{ @"digit":number(1),@".":number(3) , },  //2
                     @{ @"digit":number(4) },  //3
                     @{ @"digit":number(4), @" ":number(end), @"e":number(e) },  //4 valid
                     @{ @"sign":number(6), @"digit":number(7)},    //5  e
                     @{ @"digit":number(7)},    //6
                     @{ @"digit":number(7),@" ":number(end)},    //7 valid
                     @{ @" ":number(end) },    //8 end  valid
                     ];
    int i=0;
    int current = 0;
    while (i<str.length)
    {
        NSString* s = charAtIndex(str,i);
        NSString* key = s;
        char c = [s characterAtIndex:0];
        if(c>='0' && c<='9'){
            key = @"digit";
        }
        else if ([s isEqualToString:@"-"] || [s isEqualToString:@"+"]){
            key = @"sign";
        }
        NSNumber* next = [[dfa objectAtIndex:current] objectForKey:key];
        if (!next) {
            return NO;
        }
        current = [next intValue];
        i++;
    }
    if (current == 1 || current == 4 ||current == 7 || current == 8  ) return YES;
    return NO;
}
@end
