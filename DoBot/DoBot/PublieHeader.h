//
//  PublieHeader.h
//  DoBot
//
//  Created by 羊德元 on 16/7/15.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#ifndef PublieHeader_h
#define PublieHeader_h


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IS_IPHONE_4_OR_LESS (SCREEN_HEIGHT< 568.0)
#define IS_IPHONE_5 (SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_6 (SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6P (SCREEN_HEIGHT == 736.0)

#define BigCircle_Corlor [[UIColor alloc] initWithRed:145/255.0 green:185/255.0 blue:184/255.0 alpha:0.6]
#define SmartCircle_Corlor [[UIColor alloc] initWithRed:255/255.0 green:72/255.0 blue:82/255.0 alpha:0.8]

#define HOST @"192.168.8.1"   //路由地址

#define PORT 2001             //端口号

#define READDATAWITHTIMEOUT -1
#define WRITEDATAWITHTIMEOUT 3
#define TAG  1

#endif /* PublieHeader_h */
