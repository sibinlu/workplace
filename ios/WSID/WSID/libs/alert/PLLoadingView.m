//
//  PLLoadingView.m
//  PhotoSola
//
//  Created by motu on 11-2-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PLLoadingView.h"
#import "UIViewPLCategory.h"

#define WIDTH_MARGIN 20
#define HEIGHT_MARGIN 20

@interface PLLoadingView (PrivateMethods)
- (CGSize) calculateHeightOfTextFromWidth:(NSString*)text font: (UIFont*)withFont width:(float)width linebreak:(NSLineBreakMode)lineBreakMode;
@end


@implementation PLLoadingView
@synthesize radius;

- (id) initWithTitle:(NSString*)ttl message:(NSString*)msg{
	if(!(self = [super initWithFrame:CGRectMake(0, 0, 280, 200)])) return nil;
	
    _title = [ttl copy];
    _message = [msg copy];
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self addSubview:_activity];
    self.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
    
	
	return self;
}
- (id) initWithTitle:(NSString*)ttl{
	if(![self initWithTitle:ttl message:nil]) return nil;
	return self;	
}

- (void) drawRect:(CGRect)rect {
	
	if(self.hidden) return;
	int width, rWidth, rHeight, x;
	

	UIFont *titleFont = [UIFont boldSystemFontOfSize:16];
	UIFont *messageFont = [UIFont systemFontOfSize:12];
	
	CGSize s1 = [self calculateHeightOfTextFromWidth:_title font:titleFont width:200 linebreak:NSLineBreakByTruncatingTail ];
	CGSize s2 = [self calculateHeightOfTextFromWidth:_message font:messageFont width:200 linebreak:NSLineBreakByCharWrapping ];
	
	if([_title length] < 1) s1.height = 0;
	if([_message length] < 1) s2.height = 0;
	
	
	rHeight = (s1.height + s2.height + (HEIGHT_MARGIN*2) + 10 + _activity.frame.size.height);
	rWidth = width = (s2.width > s1.width) ? (int) s2.width : (int) s1.width;
	rWidth += WIDTH_MARGIN * 2;
	x = (280 - rWidth) / 2;
	
	_activity.center = CGPointMake(280/2,HEIGHT_MARGIN + _activity.frame.size.height/2);
	
	
	//CustomLog(@"DRAW RECT %d %f",rHeight,self.frame.size.height);
	
	// DRAW ROUNDED RECTANGLE
	[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] set];
	CGRect r = CGRectMake(x, 0, rWidth,rHeight);
	[UIView drawRoundRectangleInRect:r 
						  withRadius:10.0 
							   color:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75]];
	
	
	// DRAW FIRST TEXT
	[[UIColor whiteColor] set];
	r = CGRectMake(x+WIDTH_MARGIN, _activity.frame.size.height + 10 + HEIGHT_MARGIN, width, s1.height);
    
	CGSize s = [_title drawInRect:r withFont:titleFont lineBreakMode:NSLineBreakByTruncatingTail  alignment:UITextAlignmentCenter];
	
	
	// DRAW SECOND TEXT
	r.origin.y += s.height;
	r.size.height = s2.height;
	[_message drawInRect:r withFont:messageFont lineBreakMode:UILineBreakModeCharacterWrap alignment:UITextAlignmentCenter];
	
	CGRect r1 = CGRectInset(rect, 6, 0);
	[UIView drawRoundRectangleInRect:r1 withRadius:10 color:[UIColor clearColor]];
	
}


- (void) setTitle:(NSString*)str{
	[_title release];
	_title = [str copy];
	//[self updateHeight];
	[self setNeedsDisplay];
}
- (NSString*) title{
	return _title;
}

- (void) setMessage:(NSString*)str{
	[_message release];
	_message = [str copy];
	[self setNeedsDisplay];
}
- (NSString*) message{
	return _message;
}

- (void) setRadius:(float)f{
	if(f==radius) return;
	
	radius = f;
	[self setNeedsDisplay];
	
}

- (void) startAnimating{
	if(!self.hidden) return;
	self.hidden = NO;
	[self setNeedsDisplay];
	[_activity startAnimating];
	
}
- (void) stopAnimating{
	if(self.hidden) return;
	self.hidden = YES;
	[self setNeedsDisplay];
	[_activity stopAnimating];
	
}


- (CGSize) calculateHeightOfTextFromWidth:(NSString*)text font: (UIFont*)withFont width:(float)width linebreak:(NSLineBreakMode)lineBreakMode{
	return [text sizeWithFont:withFont 
			constrainedToSize:CGSizeMake(width, FLT_MAX) 
				lineBreakMode:lineBreakMode];
}



- (CGSize) heightWithString:(NSString*)str font:(UIFont*)withFont width:(float)width linebreak:(UILineBreakMode)lineBreakMode{
	
	
	CGSize suggestedSize = [str sizeWithFont:withFont constrainedToSize:CGSizeMake(width, FLT_MAX) lineBreakMode:lineBreakMode];
	
	return suggestedSize;
}


- (void) adjustHeight{
	
	CGSize s1 = [self heightWithString:_title font:[UIFont boldSystemFontOfSize:16.0] 
								 width:200.0 
							 linebreak:UILineBreakModeTailTruncation];
	
	CGSize s2 = [self heightWithString:_message font:[UIFont systemFontOfSize:12.0] 
								 width:200.0 
							 linebreak:UILineBreakModeCharacterWrap];
	
	CGRect r = self.frame;
	r.size.height = s1.height + s2.height + 20;
	self.frame = r;
}



- (void) dealloc{
	[_activity release];
	[_title release];
	[_message release];
	[super dealloc];
}

@end