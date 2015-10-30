//
//  ReverseTable.cpp
//  TestCPP
//
//  Created by sibinlu on 15/9/28.
//  Copyright © 2015年 sibinlu. All rights reserved.
//

#include "ReverseTable.hpp"
#include <iostream>

using namespace std;

ReverseTable::ReverseTable(int size){
    cout<<"create\n";
    tableSize = size;
    map = new int*[tableSize];
    for (int i =0; i<tableSize; i++) {
        map[i] = new int[tableSize];
    }
    resetTable();
}


ReverseTable::~ReverseTable(){
    cout<<"kill\n";
}

void ReverseTable::resetTable(){
    for (int i=0;i<tableSize; i++) {
        for (int j=0;j<tableSize; j++){
            map[i][j] = 1;
            
        }
    }
}

int ReverseTable::checkTable(){
    for (int i=0;i<tableSize; i++) {
        for (int j=0;j<tableSize; j++){
            if (map[i][j] == 1) {
                return 0;
            }
            
        }
    }
    return 1;
}

void ReverseTable::click(int i, int j){
    reverse(i, j);
    reverse(i-1, j);
    reverse(i+1, j);
    reverse(i, j-1);
    reverse(i, j+1);
}

void ReverseTable::reverse(int i, int j){
    if (i>=0 && i <tableSize && j>=0 && j <tableSize) {
        map[i][j] = abs(1 - map[i][j]);
    }
    
}

void ReverseTable::printTable(){
    for (int i=0;i<tableSize; i++) {
        for (int j=0;j<tableSize; j++){
            cout<<"  "<<map[i][j];
        }
        cout<<"\n";
    }
}

void ReverseTable::solveTable(){
    for (int t=0;t< (1<<(tableSize*tableSize+1));t++)
    {
        resetTable();
        for (int i=0; i<tableSize; i++) {
            for (int j=0; j<tableSize; j++){
                int index = i*tableSize+j;
                if( (t>>index) & 0x1){
                    click(i, j);
                }
            }
        }
        if (checkTable()) {
            cout << "Result:  " << t <<endl;
            for (int i=0; i<tableSize; i++) {
                for (int j=0; j<tableSize; j++){
                    int index = i*tableSize+j;
                    cout<< ((t>>index) & 0x1);
                }
                cout<<endl;
            }
            cout<<endl;
            printTable();
            return;
        }
    }
    cout << "NO Result!"<<endl;
}


int ReverseTable::test(){
    ReverseTable* table = new ReverseTable();
    table->printTable();
    table->solveTable();
    delete  table;
    
    return 0;
}




