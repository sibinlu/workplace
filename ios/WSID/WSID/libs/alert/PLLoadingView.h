//
//  PLLoadingView.h
//  PhotoSola
//
//  Created by motu on 11-2-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WIDTH_MARGIN 20
#define HEIGHT_MARGIN 20
#import <UIKit/UIKit.h>

@interface PLLoadingView : UIView {
	UIActivityIndicatorView *_activity;
	BOOL _hidden;
	
	NSString *_title;
	NSString *_message;
	float radius;
}
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *message;
@property (assign,nonatomic) float radius;

- (id) initWithTitle:(NSString*)title message:(NSString*)message;
- (id) initWithTitle:(NSString*)title;

- (void) startAnimating;
- (void) stopAnimating;

@end
