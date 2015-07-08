//
//  WSIDFontMgr.h
//  WSID
//
//  Created by sibinlu on 15-7-7.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLAlertCenter.h"
#define WSIDFontChangeNotification @"WSIDFontChangeNotification"
@interface WSIDFontMgr : NSObject
@property (nonatomic) NSInteger fontIndex;
+(WSIDFontMgr*) shareMgr;
-(UIFont*)fontForMainText;
-(UIFont*)fontForTopicText;

@end
