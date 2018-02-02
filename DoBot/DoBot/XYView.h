
//
//  HomeViewController.h
//  DoBot
//
//  Created by 羊德元 on 16/8/07.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYView;

@protocol XYViewClassDelegate <NSObject>

//请求XY的值
- (void)theX:(float)x andY:(float)y andRequest:(XYView *)XYClass;

//返回手势离开
- (void)InsideMethod:(XYView *)XYInside;


@end


@interface XYView : UIView


//设置按钮大小
@property (nonatomic, assign) CGFloat btnWidth;

@property (nonatomic,assign)id<XYViewClassDelegate>delegate;

@end
