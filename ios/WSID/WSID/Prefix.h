//
//  Prefix.h
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#ifndef WSID_Prefix_h
#define WSID_Prefix_h
#import "SLColorSchema.h"
#define TopBarButton( __button , __rect , __title , __sel ) \
__button = [UIButton buttonWithType:UIButtonTypeCustom]; \
__button.frame = __rect; \
[__button setTitle: __title forState:UIControlStateNormal]; \
[__button addTarget:self action:@selector(__sel) forControlEvents:UIControlEventTouchUpInside]; \
[__button setTitleColor:SLBlack forState:UIControlStateNormal]; \
[__button setTitleColor:SLBlue forState:UIControlStateHighlighted]; \
__button.titleLabel.font = [UIFont boldSystemFontOfSize:20]; \
//__button.backgroundColor = [UIColor greenColor]; \
\

#define InfoLabel( __label , __rect , __title ) \
__label = [[UILabel alloc] initWithFrame:__rect];  \
__label.text = __title;  \
__label.textColor = SLBlack; \
__label.font = [UIFont systemFontOfSize:14]; \
__label.numberOfLines = 0; \
__label.lineBreakMode = NSLineBreakByWordWrapping; \


//Random Task
#define WSIDRandomEnable 1
#define WSIDRandomPerNewDay 1
#define WSIDRandomMinTask  5

#endif



