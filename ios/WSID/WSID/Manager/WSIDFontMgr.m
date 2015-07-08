//
//  WSIDFontMgr.m
//  WSID
//
//  Created by sibinlu on 15-7-7.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDFontMgr.h"

@interface WSIDFontMgr()
@property (nonatomic,strong) NSArray* fontMainTextArray;
@property (nonatomic,strong) NSArray* fontTopicTextArray;
@property (nonatomic,strong) NSArray* alertArray;

@end

@implementation WSIDFontMgr

static WSIDFontMgr* _shareinstance = nil;
+(WSIDFontMgr*) shareMgr;{
    if (!_shareinstance) {
        _shareinstance = [[WSIDFontMgr alloc] init];
    }
    return _shareinstance;
}

-(id) init{
    self = [super init];
    if (self) {
        self.fontMainTextArray = [NSArray arrayWithObjects:
                     [UIFont systemFontOfSize:16],
                     [UIFont systemFontOfSize:18],
                     [UIFont systemFontOfSize:20],
                     [UIFont systemFontOfSize:22],nil];
        self.fontTopicTextArray = [NSArray arrayWithObjects:
                                  [UIFont systemFontOfSize:20],
                                  [UIFont systemFontOfSize:22],
                                  [UIFont systemFontOfSize:24],
                                  [UIFont systemFontOfSize:26],nil];
        
        self.alertArray = [NSArray arrayWithObjects:
                                     @"Middle",
                                     @"Big",
                                     @"Huge",
                                     @"Giant",nil];
        
        NSNumber* number = [[NSUserDefaults standardUserDefaults] objectForKey:@"WSIDFONTINDEX"];
        if (!number) {
            _fontIndex = 0;
        }
        else{
            _fontIndex = [number integerValue];
            if (_fontIndex < 0) {
                _fontIndex=0;
            }
            if (_fontIndex>=self.fontMainTextArray.count) {
                _fontIndex = self.fontMainTextArray.count - 1;
            }
        }
    }
    return self;
}

-(UIFont*)fontForMainText;{
    return [self.fontMainTextArray objectAtIndex:self.fontIndex];
}

-(UIFont*)fontForTopicText;{
    return [self.fontTopicTextArray objectAtIndex:self.fontIndex];
}

-(void)setFontIndex:(NSInteger)fontIndex{
    if (fontIndex<0 || fontIndex>= _shareinstance.fontMainTextArray.count || fontIndex == _fontIndex) {
        return;
    }
    _fontIndex = fontIndex;
    [[PLAlertCenter defaultCenter] postAlertWithMessage:[self.alertArray objectAtIndex:_fontIndex]];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_fontIndex] forKey:@"WSIDFONTINDEX"];
    [[NSNotificationCenter defaultCenter] postNotificationName:WSIDFontChangeNotification object:nil];
}

@end
