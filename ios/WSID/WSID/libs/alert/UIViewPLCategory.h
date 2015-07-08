//
//  UIView+PLCategory.h
//  PhotoSola
//
//  Created by motu on 11-2-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (PLCategory)
// DRAW GRADIENT
+ (void) drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors;
+ (void) drawLinearGradientInRect:(CGRect)rect colors:(CGFloat[])colors;


// DRAW ROUNDED RECTANGLE
+ (void) drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius color:(UIColor*)color;

// DRAW LINE
+ (void) drawLineInRect:(CGRect)rect red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors;
+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors width:(CGFloat)lineWidth cap:(CGLineCap)cap;


// Animation
+ (void) commitModalAnimations;
- (void) boundsAnimate;
- (void) slowlyShownAnimate;
- (void) shakingChoosenAnimate;
- (void) BackToNormal;
-(void) RotateAnimateWithRotation:(CGFloat)rotation withDeceleration:(BOOL)deceleration withTarget:(id)target selector:(SEL)action;

CGPoint demoLGStart(CGRect bounds);
CGPoint demoLGEnd(CGRect bounds);
CGPoint demoRGCenter(CGRect bounds);
CGFloat demoRGInnerRadius(CGRect bounds);
@end
