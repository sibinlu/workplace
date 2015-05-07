//
//  WSIDViewController.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDViewController.h"
#import "WSIDCreateViewController.h"
#import "WSIDManagerViewController.h"
#import "WSIDTaskManager.h"
#import "Prefix.h"
#import "WSIDRecitationViewController.h"
#import "WSIDLearningViewController.h"
#import "WSIDDictionaryViewController.h"



//#define TopBarButton(__button,__rect,__title,__sel,__selEnd) \
//UIButton * __button = [UIButton buttonWithType:UIButtonTypeCustom]; \
//__button.backgroundColor = [UIColor blueColor];\
//__button.frame = __rect;\
//if([self respondsToSelector:@selector(__selEnd)])[__button addTarget:self action:@selector(__selEnd) forControlEvents:UIControlEventTouchUpInside];\
//[__button addTarget:self action:@selector(__sel) forControlEvents:UIControlEventTouchDown];\
//[__button setTitle:__title forState:UIControlStateNormal];\

@interface WSIDViewController ()
{
    UIButton* button;
}
@end

@implementation WSIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //UIButton* button;
    
    TopBarButton(button , CGRectMake(20, 100, self.view.frame.size.width-40, self.view.frame.size.height -200) , @"WHAT SHOULD I DO?" , clickWSID);
    [button setTitle:@"Nothing To Do" forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.view addSubview:button];
    
    UIButton* addButton;
    TopBarButton(addButton , CGRectMake(0, 20, 50, 50) , @"+" , clickAdd);
    [self.view addSubview:addButton];
    
    UIButton* mButton;
    TopBarButton(mButton , CGRectMake(60, 20, 50, 50) , @"M" , clickM);
    [self.view addSubview:mButton];
    
    [[WSIDTaskManager manager] reload];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickWSID{
    WSIDTask* task = [[WSIDTaskManager manager] nextToDo];
    if (task) {
        WSIDTaskViewController* ctrl = nil;
        if ([task isKindOfClass:[WSIDRecitationTask class]]) {
            ctrl = [[WSIDRecitationViewController alloc] initWithTask:task];
        }
        else if ([task isKindOfClass:[WSIDLearningTask class]]) {
            ctrl = [[WSIDLearningViewController alloc] initWithTask:task];
        }
        else if ([task isKindOfClass:[WSIDDictionaryTask class]]) {
            ctrl = [[WSIDDictionaryViewController alloc] initWithTask:task];
        }
        if (ctrl) {
            [self.navigationController pushViewController:ctrl animated:YES];
        }
        else{
            button.enabled = NO;
        }
    }
    else{
        button.enabled = NO;
    }

}

-(void)clickAdd{
    WSIDCreateViewController* ctrl = [[WSIDCreateViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

-(void)clickM{
    WSIDManagerViewController * ctrl = [[WSIDManagerViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}
@end
