//
//  WSIDRecitationViewController.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDRecitationViewController.h"
#import "Prefix.h"
#import "WSIDFontMgr.h"

@interface WSIDRecitationViewController () <UITextViewDelegate>
{
    UILabel* lq;
    UITextView* la;
    UILabel* li;
    UIScrollView* scroll;
}
@end

@implementation WSIDRecitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, 900);
    [self.view addSubview:scroll];
    
    /////
    
    
    NSString* q = [self.task.questions objectAtIndex:0];
    InfoLabel(lq, CGRectMake(20, 0, scroll.frame.size.width-40, 999), q);
    [scroll addSubview:lq];
    
    CGRect rect = [q boundingRectWithSize:lq.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:lq.font forKey:NSFontAttributeName] context:nil];
    
    lq.frame = CGRectMake(20, 0, scroll.frame.size.width-40, rect.size.height);
    
    
    la = [[UITextView alloc] initWithFrame:CGRectMake(20, lq.frame.size.height + 10, scroll.frame.size.width-40, 150)];
    la.layer.borderWidth = 1;
    la.layer.borderColor = [[UIColor blackColor] CGColor];
    la.text = @"";
    la.delegate = self;
    la.autocapitalizationType = UITextAutocapitalizationTypeNone;
    la.autocorrectionType = UITextAutocorrectionTypeNo;
    [scroll addSubview:la];
    
    InfoLabel(li, CGRectMake(20, lq.frame.size.height + 10+160, scroll.frame.size.width-40, 100), @"");
    [scroll addSubview:li];
    
    int h = li.frame.origin.y + li.frame.size.height + 220;
    if (h< scroll.frame.size.height) {
        h = scroll.frame.size.height;
    }
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, h);
    
    [la becomeFirstResponder];
    
    [self resetFont];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) finish{
    [la resignFirstResponder];
    if (!hasDone) {
        checkButton.enabled = NO;
        hasDone = true;
        WSIDResult* r = [self.task checkAnswer:la.text atIndex:0];
        li.text = r.result;
        if (r.isCorrect) {
            [[WSIDTaskManager manager] finishTask:self.task];
        }
        
        
        
        CGRect rect = [li.text boundingRectWithSize:CGSizeMake(li.frame.size.width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:li.font forKey:NSFontAttributeName] context:nil];
        li.frame = CGRectMake(li.frame.origin.x, li.frame.origin.y, li.frame.size.width, rect.size.height);
        
        int h = li.frame.origin.y + li.frame.size.height + 220;
        if (h< scroll.frame.size.height) {
            h = scroll.frame.size.height;
        }
        scroll.contentSize = CGSizeMake(self.view.frame.size.width, h);
        
        int bottom = li.frame.origin.y + li.frame.size.height;
        if (bottom>scroll.frame.size.height) {
            [scroll setContentOffset:CGPointMake(0,bottom - scroll.frame.size.height) animated:YES];
        }
        
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    int bottom = textView.frame.origin.y + textView.frame.size.height;
    if (bottom>scroll.frame.size.height -216) {
        [scroll setContentOffset:CGPointMake(0,bottom - scroll.frame.size.height + 220) animated:YES];
    }
}

-(void)resetFont{
    lq.font = [[WSIDFontMgr shareMgr] fontForMainText];
    la.font = [[WSIDFontMgr shareMgr] fontForMainText];
    li.font = [[WSIDFontMgr shareMgr] fontForMainText];
    
    NSString* q = [self.task.questions objectAtIndex:0];
    CGRect rect = [q boundingRectWithSize:CGSizeMake(lq.bounds.size.width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:lq.font forKey:NSFontAttributeName] context:nil];
    
    lq.frame = CGRectMake(20, 0, scroll.frame.size.width-40, rect.size.height);
    
    NSString* a = [self.task.answers objectAtIndex:0];
    rect = [a boundingRectWithSize:CGSizeMake(la.bounds.size.width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:la.font forKey:NSFontAttributeName] context:nil];
    
    la.frame = CGRectMake(20, lq.frame.size.height + 20, scroll.frame.size.width-40, rect.size.height+40);
    li.frame = CGRectMake(20, la.frame.origin.y + la.frame.size.height + 20, scroll.frame.size.width-40, li.frame.size.height);
    
    int h = li.frame.origin.y + li.frame.size.height + 220;
    if (h< scroll.frame.size.height) {
        h = scroll.frame.size.height;
    }
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, h);
    
//    int bottom = li.frame.origin.y + li.frame.size.height;
//    if (bottom>scroll.frame.size.height) {
//        [scroll setContentOffset:CGPointMake(0,bottom - scroll.frame.size.height) animated:YES];
//    }
}
@end
