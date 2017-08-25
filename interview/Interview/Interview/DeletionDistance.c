//
//  DeletionDistance.c
//  Interview
//
//  Created by Sibin Lu on 2017/3/8.
//  Copyright © 2017年 sibinlu. All rights reserved.
//

#include "DeletionDistance.h"

int deletion_distance(char* str1, char* str2){
    if(str1[0]=='\0' && str2[0]=='\0'){
        return 0;
    }
    else if (str1[0]=='\0'){
        return str2[0] + deletion_distance(str1,str2+1);
    }
    else if (str2[0]=='\0'){
        return str1[0] + deletion_distance(str1+1,str2);
    }
    else if (str1[0]==str2[0]){
        return deletion_distance(str1+1,str2+1);
    }
    else{
        int sum1 = str2[0] + deletion_distance(str1,str2+1);
        int sum2 = str1[0] + deletion_distance(str1+1,str2);
        return (sum1 <sum2)?sum1:sum2;
    }
}
