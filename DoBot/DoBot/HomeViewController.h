//
//  HomeViewController.h
//  DoBot
//
//  Created by 羊德元 on 16/7/14.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreMotion/CoreMotion.h>
#import "AsyncSocket.h"
#import "DobotPowerCmdData.h"
#import "SystemSounds.h"
#import "XYView.h"

enum{
    
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
    
};

typedef NS_ENUM(NSUInteger, H_DoBotDataCmd) {
    
    //——————————————————————————————————————底盘——————————————————————————————————————————
    H_startPower = 0, //开启动力
    H_stopPower, //关闭动力
    H_detectionPower, //通信检测
    
    H_orientationDisChang,      //方向不变
    H_orientationOlayRight,      //方向仅仅右转
    H_orientationOlayLeft,       //方向仅仅左转
    H_orientationOlayForWard,    //只前进
    H_orientationOlayBack,       //只后退
    H_orientationOlayRise,       //只上升
    H_orientationOlayDown,       //只下降
    
    H_intoCheckSumStandardModel,       //进入校准模式
    H_outCheckSumStandardModel,        //退出校准模式
    
    H_parameterRead,             //参数读取
    H_parameterWrite,            //参数写入默认
    
    
    //——————————————————————————————————————————————机械臂————————————————————————————————
    
    H_DobotPowerStop,

    
};

@interface HomeViewController : UIViewController<UIWebViewDelegate,AsyncSocketDelegate,XYViewClassDelegate>
{
    CMMotionManager *_motionManager; //加速计
    
    UIButton *listButton;   //菜单
    
    UIButton *cameraButton; //照相
    
    UIButton *lightButton;  //调节亮度
    
    UIButton *_forWardButton;   //向前
    UIButton *_backButton;      //向后
    UIButton *_leftButton;       //向左
    UIButton *_rightButton;      //向右
    
    NSTimer *timer;              //定时器处理动画
    
    NSTimer *timeRiseDown;              //升降定时器
    
    NSTimer *forwardCtrtime;              //前进定时器
    NSTimer *backCtrtime;              //向后定时器
    NSTimer *leftCtrtime;              //向左定时器
    NSTimer *rightCtrtime;              //向右定时器
    
    
    AsyncSocket *_socket;        //Socket对象
  
    NSMutableArray *Arr;
    
    
    UISlider *ZSlider;            //Z轴驱动
    
    UIImageView *dobotBgm;           //背景图片
    UISlider *lightSlider;           //调节亮度
    
    UIView *listView;                //菜单列表
    
    XYView *_DoBotView;                //机械臂
    
    UISlider *riseDownSlider;         //机械臂升降
    
    
    UIView *theView;
    
    UILabel *sportModel;
    
}

@property (nonatomic,assign) Boolean isShow;         //是否展示菜单列表
@property (nonatomic,assign) Boolean isCheckLightChang;  //是否调节亮度
@property (nonatomic,assign) NSURLRequest *request;
@property (nonatomic,strong)UIView *lightView;        //屏幕亮度
@property (strong,nonatomic)UIButton *carButton;      //小车控制按钮
@property (strong,nonatomic)UIButton *dobotButton;    //机械臂控制按钮
@property (strong,nonatomic)UIButton *boolButton;
@property (strong,nonatomic)UIButton *showButton;  //遮罩按钮，用于是否隐藏webView,显示其它View.
@property (strong,nonatomic)UIView *CarView; //小车
@property (strong,nonatomic)UIWebView *webView;  //加载视频

@property (nonatomic,assign) Boolean isShowOtherView;  //是否显示其它View

//控制界面的方法

-(void)coverViewButton;                    //控制遮罩显示的按钮
-(void)listAction;                   //是否显示菜单
-(void)lightAction;               //调节亮度
-(void)cameraAction;         //拍照保存到本地
-(void)motionAction;        //加速计


-(void)stopAction;            //停车


//SocketMethod

-(void)socketConnentToHost;        //socket连接

-(void)cutConnent;                 //断开连接

//dobotPowerMethod

-(void)startPowerDobot;           //开启动力

-(void)stopPowerDobot;             //关闭动力

-(void)detectionPower;        //通信检测

-(void)orientationDisChang;  //方向不变
-(void)orientationOlayRight;   //方向仅仅右转
-(void)orientationOlayLeft;    //方向仅仅左转
-(void)orientationOlayForWard;  //只前进
-(void)orientationOlayBack;    //只后退
-(void)orientationOlayRise;   //只上升
-(void)orientationOlayDown;   //只下降

-(void)intoCheckSumStandardModel;       //进入校准模式
-(void)outCheckSumStandardModel;        //退出校准模式

-(void)parameterRead;             //参数读取
-(void)parameterWrite;            //参数写入默认


-(void)H_enumType:(H_DoBotDataCmd)H_type;//选择操作类型







@end
