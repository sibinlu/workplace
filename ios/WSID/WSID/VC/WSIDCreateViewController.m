//
//  WSIDCreateViewController.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDCreateViewController.h"
#import "WSIDTaskManager.h"
#import "WSIDTask.h"
#import <QuartzCore/QuartzCore.h>
#import "Prefix.h"
#import "WSIDFontMgr.h"
@interface WSIDCreateViewController () <UITextFieldDelegate,UITextViewDelegate>
{
    UITextField* name;
    UITextField* frequncy;
    UITextField* total;
    UITextView* q;
    UITextView* a;
    UIScrollView* scroll;
}
@end

@implementation WSIDCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, 340+150+220);
    [self.view addSubview:scroll];
    
    UIButton* b1;
    TopBarButton(b1 , CGRectMake(0, 20, 50, 50) , @"<" , back);
    [self.view addSubview:b1];
    
    UIButton* b2;
    TopBarButton(b2 , CGRectMake(60, 20, 50, 50) , @"√" , finish);
    [self.view addSubview:b2];
    ////
    UILabel* nameLabel;
    InfoLabel(nameLabel, CGRectMake(20, 0, 80,40),@"Name");
    [scroll addSubview:nameLabel];

    name = [[UITextField alloc] initWithFrame:CGRectMake(20+80+10, 0, self.view.frame.size.width-40-80-10, 40)];
    name.placeholder = @"TaskName";
    name.borderStyle = UITextBorderStyleRoundedRect;
    name.returnKeyType = UIReturnKeyDone;
    name.delegate = self;
    [scroll addSubview:name];
    
    //// 50
    
    UILabel* fLabel;
    InfoLabel(fLabel, CGRectMake(20, 50, 80,40),@"Times p.w.");
    [scroll addSubview:fLabel];
    
    frequncy = [[UITextField alloc] initWithFrame:CGRectMake(20 +80 +10,  50 , 60, 40)];
    frequncy.placeholder = @"Frequency";
    frequncy.borderStyle = UITextBorderStyleRoundedRect;
    frequncy.returnKeyType = UIReturnKeyDone;
    [scroll addSubview:frequncy];
    frequncy.text = @"7";
    
    UILabel* tLabel;
    InfoLabel(tLabel, CGRectMake(20 +80 +10 +60+10, 50, 60,40),@"Total");
    [scroll addSubview:tLabel];
    
    total = [[UITextField alloc] initWithFrame:CGRectMake(20 +80 +10 +60+10 + 60 + 10,  50 , 60, 40)];
    total.placeholder = @"Total";
    total.borderStyle = UITextBorderStyleRoundedRect;
    total.returnKeyType = UIReturnKeyDone;
    [scroll addSubview:total];
    total.text = @"21";
    
    /// 100
    UILabel* qLabel;
    InfoLabel(qLabel, CGRectMake(20, 100, 80,40),@"Question:");
    [scroll addSubview:qLabel];
    
    q = [[UITextView alloc] initWithFrame:CGRectMake(20, 140, self.view.frame.size.width-40, 150)];
    q.layer.borderWidth =1;
    q.delegate = self;
    q.layer.borderColor =[[UIColor blackColor]CGColor];;
    q.autocapitalizationType = UITextAutocapitalizationTypeNone;
    q.autocorrectionType = UITextAutocorrectionTypeNo;
    [scroll addSubview:q];

    //300
    UILabel* aLabel;
    InfoLabel(aLabel, CGRectMake(20, 300, 80,40),@"Answer:");
    [scroll addSubview:aLabel];
    
    a = [[UITextView alloc] initWithFrame:CGRectMake(20, 340, self.view.frame.size.width-40, 150)];
    a.layer.borderWidth =1;
    a.delegate = self;
    a.layer.borderColor =[[UIColor blackColor]CGColor];;
    a.autocapitalizationType = UITextAutocapitalizationTypeNone;
    a.autocorrectionType = UITextAutocorrectionTypeNo;
    [scroll addSubview:a];

    [self supportGestureAdjustFont];
    [self resetFont];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)finish{
    NSString* s_name = [name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* s_q = [q.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* s_a = [a.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int f = [frequncy.text intValue];
    int t = [total.text intValue];
    if ([s_name isEqualToString:@""] || [s_q isEqualToString:@""] ) {
        return;
    }
    WSIDTask* task;
    if ([s_a isEqualToString:@""]){
        task = [[WSIDLearningTask alloc] init];
    }
    else{
        task = [[WSIDRecitationTask alloc] init];
    }
    task.taskName = s_name;
    task.questions = [NSArray arrayWithObject:s_q];
    task.answers = [NSArray arrayWithObject:s_a];
    task.countFinished =0;
    task.countTotal = t;
    task.taskFrequncy = f;
    task.finishThisWeek = 0;
    task.finishToday = 0;
    task.taskid = [NSString stringWithFormat:@"%d" ,(int)[[NSDate date] timeIntervalSince1970]];
    [[WSIDTaskManager manager].tasks addObject:task];
    [[WSIDTaskManager manager] save];
    [self back];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    int bottom = textView.frame.origin.y + textView.frame.size.height;
    if (bottom>scroll.frame.size.height -216) {
        [scroll setContentOffset:CGPointMake(0,bottom - scroll.frame.size.height + 220) animated:YES];
    }
}

-(void)resetFont{
    q.font = [[WSIDFontMgr shareMgr] fontForMainText];
    a.font = [[WSIDFontMgr shareMgr] fontForMainText];
}

-(void)notifyFontChange:(NSObject*)sender{
    [self resetFont];
}
@end
