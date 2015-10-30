//
//  Array.hpp
//  TestCPP
//
//  Created by sibinlu on 15/9/28.
//  Copyright © 2015年 sibinlu. All rights reserved.
//

#ifndef Array_hpp
#define Array_hpp

#include <stdio.h>

namespace Array {
    void test();
    void print(int* array, int length);
    int* createRandomArray(int length, int min, int max);
}

#endif /* Random_hpp */
