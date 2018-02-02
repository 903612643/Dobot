//
//  CoustomView.h
//  DoBot
//
//  Created by 羊德元 on 16/8/4.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonBlock) (id sender);

@interface CoustomView : UIView

- (void)addButtonAction:(ButtonBlock)block;


@property (nonatomic, strong) ButtonBlock block;
@property (nonatomic, strong) UIButton *button;

-(instancetype)initWithFrame:(CGRect)frame;



@end
