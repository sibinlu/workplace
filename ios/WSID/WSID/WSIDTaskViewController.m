//
//  WSIDTaskViewController.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDTaskViewController.h"
#import "WSIDViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Prefix.h"
@interface WSIDTaskViewController () <UITextViewDelegate>
{
    UILabel* ln;
    
    

}
@end

@implementation WSIDTaskViewController
-(id)initWithTask:(WSIDTask*) task;{
    self = [super init];
    if (self) {
        self.task = task;
        hasDone = false;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIButton* b1;
    TopBarButton(b1 , CGRectMake(0, 20, 50, 50) , @"<" , back);
    [self.view addSubview:b1];
    
    TopBarButton(checkButton , CGRectMake(60, 20, 50, 50) , @"C" , finish);
    [checkButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.view addSubview:checkButton];

    InfoLabel(ln, CGRectMake(160, 20, 150, 50), self.task.taskName);
    ln.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:ln];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) finish{
    hasDone = YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        if (hasDone) {
            if ([self lastVCisWSID]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:WSIDJumpToNextTaskNotification object:nil];
                
            }
            else{
                [self back];
            }
        }
    }
}

-(BOOL)lastVCisWSID{
    return self.navigationController.viewControllers.count==2;
}

@end
