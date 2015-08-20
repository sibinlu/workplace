//
//  PLAlertCenter.m
//  PhotoSola
//
//  Created by motu on 11-2-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PLAlertCenter.h"
#import "UIViewPLCategory.h"



@interface PLAlertCenter()
@property (nonatomic,retain) NSMutableArray *alerts;
@end


@interface PWAlertView : UIView {
	CGRect messageRect;
	NSString *text;
	UIImage *image;
}

- (id) init;
- (void) setMessageText:(NSString*)str;
- (void) setImage:(UIImage*)image;

@end



@implementation PLAlertCenter
@synthesize alerts;

+ (PLAlertCenter*) defaultCenter {
	static PLAlertCenter *defaultCenter = nil;
	if (!defaultCenter) {
		defaultCenter = [[PLAlertCenter alloc] init];
	}
	return defaultCenter;
}

- (id) init{
	if(!(self=[super init])) return nil;
	
	self.alerts = [NSMutableArray array];
	alertView = [[PWAlertView alloc] init];
	active = NO;
	
	[[UIApplication sharedApplication].keyWindow addSubview:alertView];
	
	
	return self;
}
- (void) showAlerts{
	
	if([self.alerts count] < 1) {
		active = NO;
		return;
	}
	
	active = YES;
	
	alertView.transform = CGAffineTransformIdentity;
	alertView.alpha = 0;
	[[UIApplication sharedApplication].keyWindow addSubview:alertView];
	
	
	
	NSArray *ar = [self.alerts objectAtIndex:0];
	
	UIImage *img = nil;
	if([ar count] > 1) img = [[self.alerts objectAtIndex:0] objectAtIndex:1];
	
	[alertView setImage:img];
	
	if([ar count] > 0) [alertView setMessageText:[[self.alerts objectAtIndex:0] objectAtIndex:0]];
	
	alertView.center = [UIApplication sharedApplication].keyWindow.center;
	
	
	
	CGRect rr = alertView.frame;
	rr.origin.x = (int)rr.origin.x;
	rr.origin.y = (int)rr.origin.y;
	alertView.frame = rr;
	
	UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
	CGFloat degrees = 0;
	if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
	else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
	else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
	alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	alertView.transform = CGAffineTransformScale(alertView.transform, 2, 2);
	
	
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.15];
    //[UIView setAnimationDuration:2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationStep2)];
	
	
	alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	alertView.frame = CGRectMake((int)alertView.frame.origin.x, (int)alertView.frame.origin.y, alertView.frame.size.width, alertView.frame.size.height);
	
	alertView.alpha = 1;
	[UIView commitAnimations];
	
	
}
- (void) animationStep2{
	[UIView beginAnimations:nil context:nil];
	
	// depending on how many words are in the text
	// change the animation duration accordingly
	// avg person reads 200 words per minute
	NSArray * words = [[[self.alerts objectAtIndex:0] objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	double duration = MAX(((double)[words count]*60.0/200.0),1);
	//double duration = MAX(((double)[words count]*60.0/100.0),2);
	[UIView setAnimationDelay:duration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationStep3)];
	
	UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
	CGFloat degrees = 0;
	if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
	else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
	else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
	alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	alertView.transform = CGAffineTransformScale(alertView.transform, 0.5, 0.5);
	
	alertView.alpha = 0;
	[UIView commitAnimations];
}
- (void) animationStep3{
	[alertView removeFromSuperview];
	[alerts removeObjectAtIndex:0];
	[self showAlerts];
	
}
- (void) postAlertWithMessage:(NSString*)message image:(UIImage*)image{
    //disable multi alerts
	if([self.alerts count] ==0)
    {
        [self.alerts addObject:[NSArray arrayWithObjects:NSLocalizedString(message,message),image,nil]];
    }
	if(!active) [self showAlerts];
}
- (void) postAlertWithMessage:(NSString*)message{
	[self postAlertWithMessage:NSLocalizedString(message,message) image:nil];
}
- (void) dealloc{
	[alerts release];
	[alertView release];
	[super dealloc];
}

@end





@implementation PWAlertView

- (id) init{
	
	if(!(self = [super initWithFrame:CGRectMake(0, 0, 100, 100)])) return nil;
	
	messageRect = CGRectInset(self.bounds, 10, 10);
	self.backgroundColor = [UIColor clearColor];
	
	return self;
	
}
- (void) adjust{
	
	CGSize s = [text sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(160,200) lineBreakMode:NSLineBreakByWordWrapping];
	
	float imageAdjustment = 0;
	if (image) {
		imageAdjustment = 7+image.size.height;
	}
	
	self.bounds = CGRectMake(0, 0, s.width+40, s.height+15+15+imageAdjustment);
	
	messageRect.size = s;
	messageRect.size.height += 5;
	messageRect.origin.x = 20;
	messageRect.origin.y = 15+imageAdjustment;
	
	[self setNeedsLayout];
	[self setNeedsDisplay];
	
}
- (void) setMessageText:(NSString*)str{
	[text release];
	text = [str retain];
	[self adjust];
}
- (void) setImage:(UIImage*)img{
	[image release];
	image = [img retain];
	
	[self adjust];
}
- (void) drawRect:(CGRect)rect{
	[UIView drawRoundRectangleInRect:rect withRadius:10 color:[UIColor colorWithWhite:0 alpha:0.8]];
	[[UIColor whiteColor] set];
	[text drawInRect:messageRect withFont:[UIFont boldSystemFontOfSize:14] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
	
	CGRect r = CGRectZero;
	r.origin.y = 15;
	r.origin.x = (rect.size.width-image.size.width)/2;
	r.size = image.size;
	
	[image drawInRect:r];
}
- (void) dealloc{
	[text release];
	[image release];
	[super dealloc];
}

@end