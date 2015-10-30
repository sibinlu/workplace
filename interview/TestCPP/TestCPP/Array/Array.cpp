//
//  Array.cpp
//  TestCPP
//
//  Created by sibinlu on 15/9/28.
//  Copyright © 2015年 sibinlu. All rights reserved.
//

#include "Array.hpp"
#include <ctime>
#include <stdlib.h>
#include <iostream>

namespace Array{
    void test(){
        int length = 10;
        int* array = createRandomArray(length, -10, 10);
        print(array, length);
        delete [] array;
    }
    void print(int* array, int length){
        for (int i =0; i<length; i++) {
            std::cout<<" "<<array[i];
        }
        std::cout<<std::endl;
    }
    
    int* createRandomArray(int length, int min, int max){
        int* array = new int[length];
        int range = max-min;
        srand((unsigned int)std::time(0));
        
        for (int i =0; i<length; i++) {
            int r = rand()%range;
            array[i]=r+min;
        }
        
        return array;
    }
}
