//
//  SLColorSchema.h
//  WSID
//
//  Created by sibinlu on 15/8/17.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#ifndef WSID_SLColorSchema_h
#define WSID_SLColorSchema_h


#define Color(__rgb) ([UIColor colorWithRed:((__rgb >> 16) & 0xFF)/255.0f green:((__rgb >> 8) & 0xFF)/255.0f blue:(__rgb & 0xFF)/255.0f alpha:1])


#define Solarized_Light
#define SLBlack Color(0x475B62)
#define SLRed Color(0xBD3613)
#define SLCrimson Color(0xD11C24)
#define SLPurple Color(0x595AB7)
#define SLPink Color(0xC61C6F)
#define SLBrown Color(0xA57706)
#define SLTeal Color(0x536870)
#define SLGray Color(0x7F7F7F)
#define SLGreen Color(0x259286)
#define SLBlue Color(0x2176C7)
#define SLBGColor Color(0xFCF4DC)
#define SLBGSelectColor Color(0xBAB39B)

#define Solarized_Dark
#define SDWhile Color(0x819090)
#define SDRed Color(0xBD3613)
#define SDCrimson Color(0xD11C24)
#define SDPurple Color(0x595AB7)
#define SDPink Color(0xC61C6F)
#define SDBrown Color(0xA57706)
#define SDTeal Color(0x708284)
#define SDGray Color(0x7F7F7F)
#define SDGreen Color(0x259286)
#define SDBlue Color(0x2176C7)
#define SDBGColor Color(0x042029)
#define SDBGSelectColor Color(0x1C3B45)




#endif
