//
//  WSIDVC.m
//  WSID
//
//  Created by sibinlu on 15-7-7.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDVC.h"
#import "WSIDFontMgr.h"

@implementation WSIDVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = SLBGColor;
}

-(void)supportGestureAdjustFont;{
    UIPinchGestureRecognizer* gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:gesture];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyFontChange:) name:WSIDFontChangeNotification object:nil];
    
}

-(void)handleGesture:(UIPinchGestureRecognizer*) sender;
{
    if(sender.state == UIGestureRecognizerStateEnded){
        if (sender.scale<1) {
            [WSIDFontMgr shareMgr].fontIndex = [WSIDFontMgr shareMgr].fontIndex - 1;
        }
        else if (sender.scale>1) {
            [WSIDFontMgr shareMgr].fontIndex = [WSIDFontMgr shareMgr].fontIndex + 1;
        }
    }
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)notifyFontChange:(NSObject*)sender{
    
}
@end
