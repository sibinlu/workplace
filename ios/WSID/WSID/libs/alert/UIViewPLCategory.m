//
//  UIView+PLCategory.m
//  PhotoSola
//
//  Created by motu on 11-2-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewPLCategory.h"

@interface UIViewPSLDelegate : NSObject {
    CFRunLoopRef currentLoop;
}
@end

@implementation UIViewPSLDelegate

-(id) initWithRunLoop:(CFRunLoopRef) runLoop
{
    if ((self=[super init])) {
        currentLoop = runLoop;
    }
    return self;
}

-(void) animationFinished:(id) sender
{
    CFRunLoopStop(currentLoop);
}

@end

@implementation UIView (PLCategory)
CGPoint demoLGStart(CGRect bounds){
	return CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height * 0.25);
}
CGPoint demoLGEnd(CGRect bounds){
	return CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height * 0.75);
}
CGPoint demoRGCenter(CGRect bounds){
	return CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
}
CGFloat demoRGInnerRadius(CGRect bounds){
	CGFloat r = bounds.size.width < bounds.size.height ? bounds.size.width : bounds.size.height;
	return r * 0.125;
}


+ (void) drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors{
	
	NSMutableArray *ar = [NSMutableArray array];
	for(UIColor *c in colors){
		[ar addObject:(id)c.CGColor];
	}
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	
	
	CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
	
	
	CGContextClipToRect(context, rect);
	
	CGPoint start = CGPointMake(0.0, 0.0);
	CGPoint end = CGPointMake(0.0, rect.size.height);
	
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
	
}


+ (void) drawLinearGradientInRect:(CGRect)rect colors:(CGFloat[])colours{
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colours, NULL, 2);
	CGColorSpaceRelease(rgb);
	CGPoint start, end;
	
	start = demoLGStart(rect);
	end = demoLGEnd(rect);
	
	
	
	CGContextClipToRect(context, rect);
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(gradient);
	
	CGContextRestoreGState(context);
	
}



+ (void) drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius color:(UIColor*)color{
	CGContextRef context = UIGraphicsGetCurrentContext();
	[color set];
	
	CGRect rrect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height );
	
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFill);
}


+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors {
	
	[UIView drawLineInRect:rect colors:colors width:1 cap:kCGLineCapButt];
	
}
+ (void) drawLineInRect:(CGRect)rect red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
	CGFloat colors[4];
	colors[0] = red;
	colors[1] = green;
	colors[2] = blue;
	colors[3] = alpha;
	[UIView drawLineInRect:rect colors:colors];
}
+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors width:(CGFloat)lineWidth cap:(CGLineCap)cap{
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	
	CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
	CGContextSetLineCap(context,cap);
	CGContextSetLineWidth(context, lineWidth);
	
	CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
	CGContextAddLineToPoint(context,rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
	CGContextStrokePath(context);
	
	
	CGContextRestoreGState(context);
	
}

//animation addtion
+(void)commitModalAnimations
{
    CFRunLoopRef currentRunLoop  = CFRunLoopGetCurrent();
    
    UIViewPSLDelegate * uivdelegate = [[UIViewPSLDelegate alloc] initWithRunLoop:currentRunLoop];
    [UIView setAnimationDelegate: uivdelegate];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];
    
    CFRunLoopRun();
    
    [uivdelegate release];
}

-(void)boundsAnimate
{
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];
    self.transform = CGAffineTransformMakeScale(1.15f, 1.15f);
    [UIView commitModalAnimations];

    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitAnimations];
}

-(void)slowlyShownAnimate
{
    self.userInteractionEnabled = NO;
    self.alpha = 0;
    /*
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.1];
    self.alpha=0.5;
    [UIView commitModalAnimations];
    */
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.alpha =1;
    [UIView commitAnimations];
    
    self.userInteractionEnabled=YES;
}

-(void) shakingChoosenAnimate
{
    self.userInteractionEnabled = NO;
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.06];
    self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.01f, 1.01f), CGAffineTransformMakeRotation( M_PI/25));
    [UIView commitModalAnimations];
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.05];
    self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.04f, 1.04f), CGAffineTransformMakeRotation(- M_PI/30));
    [UIView commitModalAnimations];
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.04];
    self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.07f, 1.07f), CGAffineTransformMakeRotation( M_PI/35));
    [UIView commitModalAnimations];
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.03];
    self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.10f, 1.10f), CGAffineTransformMakeRotation(- M_PI/40));
    [UIView commitModalAnimations];
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.05];
    self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.13f, 1.13f), CGAffineTransformMakeRotation(0));
    [UIView commitModalAnimations];
    self.userInteractionEnabled = YES;
}

-(void) BackToNormal
{
    self.userInteractionEnabled = NO;
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.1];
    self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0f, 1.0f), CGAffineTransformMakeRotation(0));
    [UIView commitAnimations];
    
    self.userInteractionEnabled = YES;
}

-(void) RotateAnimateWithRotation:(CGFloat)rotation withDeceleration:(BOOL)deceleration withTarget:(id)target selector:(SEL)action
{
    if (deceleration) {
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2];
        self.transform = CGAffineTransformMakeRotation(rotation + rotation/5);
        [UIView commitModalAnimations];
        
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        if(target!=nil)
        {
            [UIView setAnimationDelegate:target];
            [UIView setAnimationDidStopSelector:action];
        }
        
        [UIView setAnimationDuration:0.1];
        self.transform = CGAffineTransformMakeRotation(rotation);
        [UIView commitModalAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        if(target!=nil)
        {
            [UIView setAnimationDelegate:target];
            [UIView setAnimationDidStopSelector:action];
        }
        [UIView setAnimationDuration:0.1];
        self.transform = CGAffineTransformMakeRotation(rotation);
        [UIView commitAnimations];
    }
}

@end
