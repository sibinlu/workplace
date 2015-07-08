//
//  WSIDLearningViewController.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDLearningViewController.h"
#import "Prefix.h"
#import "WSIDFontMgr.h"
@interface WSIDLearningViewController ()
{
    UILabel* questionLabel;
}
@end

@implementation WSIDLearningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect =CGRectMake(20, 100, self.view.frame.size.width-40, self.view.frame.size.height -200);
    InfoLabel(questionLabel, rect, [self.task.questions objectAtIndex:0]);
    //questionLabel.font = [UIFont systemFontOfSize:28];
    questionLabel.textAlignment = NSTextAlignmentCenter;
    questionLabel.numberOfLines = 10;
    questionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:questionLabel];
    
    [self resetFont];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)finish{
    if (!hasDone) {
        checkButton.enabled = NO;
        hasDone = true;
        WSIDResult* r = [self.task checkAnswer:@"" atIndex:0];
        if (r.isCorrect) {
            [[WSIDTaskManager manager] finishTask:self.task];
        }
        [self back];
    }
}

-(void)resetFont{
    questionLabel.font = [[WSIDFontMgr shareMgr] fontForTopicText];
}
@end
