//
//  ReverseTable.hpp
//  TestCPP
//
//  Created by sibinlu on 15/9/28.
//  Copyright © 2015年 sibinlu. All rights reserved.
//

#ifndef ReverseTable_hpp
#define ReverseTable_hpp

#include <stdio.h>

class ReverseTable {
    ReverseTable(int size=5);

    ~ReverseTable();
    int** map;
    
    void resetTable();
    void click(int i, int j);
    void reverse(int i, int j);
    int checkTable();
    void solveTable();
    
public:
    void printTable();
    static int test();
    int tableSize;
};




#endif /* ReverseTable_hpp */
