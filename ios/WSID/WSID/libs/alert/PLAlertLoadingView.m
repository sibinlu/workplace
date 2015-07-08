//
//  PLAlertLoadingView.m
//  PhotoSola
//
//  Created by motu on 11-2-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PLAlertLoadingView.h"
#import "UIViewPLCategory.h"


@implementation PLAlertLoadingView
@synthesize loadingView;
@synthesize desc;


- (id) initWithTitle:(NSString*)txt{
	if(![super initWithFrame:CGRectZero]) return nil;
	self.frame=CGRectMake(0, 0, 60, 60);
	self.desc = txt;
	
	return self;
}

- (void) drawRect:(CGRect)rect{
	CGRect r = CGRectInset(rect, 6, 0);
	[UIView drawRoundRectangleInRect:r withRadius:10 color:[UIColor clearColor]];
}


- (void) show{
	[super show];
	
	for (UIView *subview in [self subviews]) {
		if ([subview isKindOfClass:[UIImageView class]])  subview.hidden = YES;
	}
	
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.loadingView];
}
- (void) hide{
	[self dismissWithClickedButtonIndex:0 animated:NO];
}


- (PLLoadingView *) loadingView{
	if(loadingView==nil){
		loadingView = [[PLLoadingView alloc] initWithTitle:self.desc];
		CGRect r = self.loadingView.frame;
		r.origin.x = 0;
		r.origin.y = 0;
		self.loadingView.frame = r;
	}
	return loadingView;
}

- (void)dealloc {
	[loadingView release];
	[super dealloc];
}
@end
