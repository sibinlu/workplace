//
//  PLAlertCenter.h
//  PhotoSola
//
//  Created by motu on 11-2-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PWAlertView;
@interface PLAlertCenter : NSObject {
	NSMutableArray *alerts;
	BOOL active;
	PWAlertView *alertView;
	
}

+ (PLAlertCenter*) defaultCenter;

- (void) postAlertWithMessage:(NSString*)message image:(UIImage*)image;
- (void) postAlertWithMessage:(NSString *)message;


@end
