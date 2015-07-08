//
//  PLAlertLoadingView.h
//  PhotoSola
//
//  Created by motu on 11-2-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLLoadingView.h"
#import <UIKit/UIKit.h>
@interface PLAlertLoadingView : UIAlertView {
	PLLoadingView *loadingView;
	NSString *desc;

}
- (id) initWithTitle:(NSString*)title;

@property (retain,nonatomic,readonly) PLLoadingView *loadingView;
@property (retain,nonatomic) NSString *desc;

- (void) show;
- (void) hide;
@end
