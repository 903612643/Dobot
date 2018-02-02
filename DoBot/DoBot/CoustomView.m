//
//  CoustomView.m
//  DoBot
//
//  Created by 羊德元 on 16/8/4.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import "CoustomView.h"

@implementation CoustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.button.frame = CGRectMake(0, 0, 100, 100);
        self.button.backgroundColor = [UIColor blackColor];
        [self addSubview:self.button];
        [self.button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

//实现block回调的方法
- (void)addButtonAction:(ButtonBlock)block {
    self.block = block;
}

- (void)buttonAction {
    if (self.block) {
        self.block(self);
    }
}


@end
