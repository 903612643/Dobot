
//
//  HomeViewController.h
//  DoBot
//
//  Created by 羊德元 on 16/8/07.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import "XYView.h"

#define WIDTHBTN 15

typedef NS_ENUM(NSUInteger,NSchange){
    
    NSISXCENTER = 11,
    NSISYCENTER ,
    
};

@interface XYView()
{
    BOOL isCenter;
    NSchange last_center;
    int last_x_width;
    int last_y_height;
    int x_width;
    int y_height;
    int x_center;
    int y_center;
    CGFloat BTNWIDTH;

    
}
@property (nonatomic, weak) UIButton *btn;

@end

@implementation XYView

- (void)setBtnWidth:(CGFloat)btnWidth{
    if (btnWidth) {
        _btnWidth = btnWidth;
        BTNWIDTH = btnWidth * 1.0;
        self.btn.frame = CGRectMake((x_center-btnWidth*0.5), (y_center-btnWidth*0.5), btnWidth, btnWidth);
        self.btn.layer.cornerRadius = btnWidth*0.5;
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isCenter = YES;
        self.userInteractionEnabled = YES;
        x_width = frame.size.width;
        y_height = frame.size.height;
        x_center = x_width*0.5;
        y_center = y_height*0.5;
        BTNWIDTH = 30;
        UIView *lineX = [[UIView alloc] initWithFrame:CGRectMake(0, y_center-0.5, x_width, 2)];
        lineX.backgroundColor = [UIColor grayColor];
        [self addSubview:lineX];
        
        UIView *lineY = [[UIView alloc] initWithFrame:CGRectMake(x_center - 0.5, 0, 2, y_height)];
        lineY.backgroundColor = [UIColor grayColor];
        [self addSubview:lineY];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BTNWIDTH, BTNWIDTH)];
        btn.center = CGPointMake(x_center, y_center);
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = BTNWIDTH*0.5;
        btn.clipsToBounds = YES;
        self.btn = btn;
        [self addSubview:btn];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
    }
    return self;
}

//开始点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self setPoint:point];
}
//结束点击
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self goToCenter];
}
- (void)pan:(UIPanGestureRecognizer *)pan
{
    isCenter = NO;
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        [self goToCenter];
    }
    CGPoint point = [pan locationInView:self];
    if ( point.x < x_width && point.y < y_height && point.x > 0 && point.y > 0) {
        [self setPoint:point];
    }
    
}
#pragma mark - 点击的位置

- (void)setPoint:(CGPoint)point
{
    CGFloat x = point.x;
    CGFloat y = point.y;
    CGFloat xx = 0.0;
    CGFloat yy = 0.0;
    if (x > x_center && y < y_center) {
        xx = x-x_center;
        yy = y_center - y;
    }else if (x < x_center && y < y_center) {
        xx = x_center - x;
        yy = y_center - y;
    }else if (x < x_center && y > y_center) {
        xx = x_center - x;
        yy = y - y_center;
    }else if (x > x_center && y > y_center) {
        xx = x - x_center;
        yy = y - y_center;
    }
    if (xx <= BTNWIDTH*0.5 || yy <= BTNWIDTH*0.5) {
    }else{
        return;
    }
    
    //    BTNWIDTH
    if (xx - yy > BTNWIDTH*0.25) {
        if (last_center != NSISYCENTER && last_center && !isCenter) {
            if (sqrt(pow(fabs(x-last_x_width), 2)+pow(fabs(y-last_y_height), 2)) > WIDTHBTN) {
                NSLog(@"==%d %lu %d",last_center != NSISXCENTER,(unsigned long)last_center,isCenter);
                return;
            }
        }
        self.btn.center = CGPointMake(x, y_center);
        last_center = NSISYCENTER;
    }else if(yy - xx > BTNWIDTH*0.25){
        if (last_center != NSISXCENTER && last_center && !isCenter) {
            if (sqrt(pow(fabs(x-last_x_width), 2)+pow(fabs(y-last_y_height), 2)) > WIDTHBTN) {
                NSLog(@"--%d %lu %d",last_center != NSISXCENTER,(unsigned long)last_center,isCenter);
                return;
            }
        }
        self.btn.center = CGPointMake(x_center, y);
        last_center = NSISXCENTER;
    }else{
        if (self.btn.center.x == x_center) {
            self.btn.center = CGPointMake(x_center, y);
            last_center = NSISXCENTER;
        }else{
            self.btn.center = CGPointMake(x, y_center);
            last_center = NSISYCENTER;
        }
    }
    last_x_width = x;
    last_y_height = y;
//    NSLog(@"%f %f",self.btn.center.x,self.btn.center.y);
    
    if (_delegate!=nil && [_delegate respondsToSelector:@selector(theX:andY:andRequest:)]) {
        
        [_delegate theX:self.btn.center.x andY:self.btn.center.y andRequest:self];
    }
    
}


#pragma mark - 回到原点

- (void)goToCenter
{
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.btn.center = CGPointMake(x_center, y_center);
            isCenter = YES;
            
            if (_delegate!=nil && [_delegate respondsToSelector:@selector(InsideMethod:)]) {
                
                [_delegate InsideMethod:self];
            }

            
        } completion:nil];
    }];
    
}


@end
