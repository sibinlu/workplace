//
//  WSIDTaskViewController.h
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSIDTask.h"
#import "WSIDTaskManager.h"
#import "WSIDVC.h"
@interface WSIDTaskViewController : WSIDVC
{
    BOOL hasDone;
    UIButton* checkButton;
    
}
@property (strong, nonatomic) WSIDTask * task;
@property (strong, nonatomic) WSIDResult *result;
-(id)initWithTask:(WSIDTask*) task;
-(void) finish;
-(void) back;
@end
