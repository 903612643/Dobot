//
//  HomeViewController.m
//  DoBot
//
//  Created by 羊德元 on 16/7/14.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import "HomeViewController.h"
#import "SettingViewController.h"

static float BigCircle_Size=150.00;       //大圆的直径
static float SmartCircle_Size=90.00;      //小圆的直径
static float Anmation_Time=3.0;           //动画时间


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface HomeViewController ()

@end

struct cmdUpload               //data字段，单精度浮点类型
{
    float state;
    float axis;
    float x;
    float y;
    float z;
    float RHead;
    float isGrab;
    float StartVe;
    float EndVel;
    float MaxVe;
};

struct cmdUpload stufloatAll;

@implementation HomeViewController

- (BOOL)prefersStatusBarHidden {

    return NO;
}

//页面将要消失，释放内存
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    self.carButton=nil;
    self.dobotButton=nil;
    self.boolButton=nil;
    self.showButton=nil;
    _CarView=nil;
    self.webView=nil;
    [timer invalidate];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[self prefersStatusBarHidden];   //显示状态栏
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    
    //默认不展示菜单列表
    _isShow=NO;
    
    //默认不调节亮度
    _isCheckLightChang=NO;
    
    //默认不显示其它按钮
    _isShowOtherView=NO;
    
    [self addWebView];                       //加载图像
    
    [self addCarButtonAndDoBot];             //加载车盘按钮和机械臂按钮
    
   // [self coverViewButton];                  //遮罩按钮，控制显示其它控制
    
    [self listViewShow];                      //添加列表菜单
    
   // [self theAnimationAction:Anmation_Time];           //执行动画，消失其它控件，只显示webView
    [self add_forWard_Back_left_rightView];  //加载前后左右控制小车按钮
    
    [self addDobotSlider];                  //机械臂控制

    _DoBotView = [[XYView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-BigCircle_Size, SCREEN_HEIGHT-BigCircle_Size,BigCircle_Size, BigCircle_Size)];
    _DoBotView.delegate=self;
    _DoBotView.layer.cornerRadius=BigCircle_Size/2;
    _DoBotView.layer.masksToBounds=YES;
    _DoBotView.backgroundColor = [UIColor greenColor];
    _DoBotView.btnWidth = SmartCircle_Size;//设置按钮的直径
    [self.view addSubview:_DoBotView];
    
    _forWardButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _forWardButton.frame=CGRectMake(70, -5, 40, 40);
    [_forWardButton setTitle:@"Y" forState:UIControlStateNormal];
    [_forWardButton bringSubviewToFront:_showButton];
    _forWardButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [_forWardButton setTintColor:[UIColor whiteColor]];
    _forWardButton.backgroundColor=[UIColor clearColor];
    [_DoBotView addSubview:_forWardButton];
    
    _forWardButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _forWardButton.frame=CGRectMake(115, 68, 40, 40);
    [_forWardButton setTitle:@"X" forState:UIControlStateNormal];
    [_forWardButton bringSubviewToFront:_showButton];
    _forWardButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [_forWardButton setTintColor:[UIColor whiteColor]];
    _forWardButton.backgroundColor=[UIColor clearColor];
    [_DoBotView addSubview:_forWardButton];

    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(testTime) userInfo:nil repeats:NO];
    
}

-(void)testTime
{
    //[self H_enumType:H_orientationOlayForWard];
    
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:@"Warm Tips " message:@"Please Check WIFI For Dobot" preferredStyle:UIAlertControllerStyleAlert];

  
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    //    把事件添加到控制器
    [alertViewCtr addAction:cancelAction];
   // [alertViewCtr addAction:sureAction1];
   
    
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^{
        
    }];

    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark Slider

-(void)addDobotSlider
{
    NSArray *title=@[@"Z",@"Y",@"X"];
    
    for (int i=0; i<3; i++) {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150*2)/4+75*(i+2)-5, SCREEN_HEIGHT-10, 20, 20)];
        lable.text=title[i];
       // [self.view addSubview:lable];
        
    }
    
    ZSlider = [[UISlider alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-260),SCREEN_HEIGHT-85, 150, 20)];
    //设置未滑动位置背景图片
    [ZSlider setMinimumTrackImage:[UIImage imageNamed:@"main_slider_bg_1.png"] forState:UIControlStateNormal];
    //设置已滑动位置背景图
    [ZSlider setMaximumTrackImage:[UIImage imageNamed:@"main_slider_bg_1.png"] forState:UIControlStateNormal];
    //设置滑块图标图片
    [ZSlider setThumbImage:[UIImage imageNamed:@"main_slider_btn.png"] forState:UIControlStateNormal];
    //设置点击滑块状态图标
    [ZSlider setThumbImage:[UIImage imageNamed:@"main_slider_btn.png"] forState:UIControlStateHighlighted];
    
    ZSlider.transform =  CGAffineTransformMakeRotation( M_PI * 0.5 );
    ZSlider.minimumValue = 0.00;         //设置最小值
    ZSlider.maximumValue = 100.00;        //设置最大值
    ZSlider.backgroundColor=[UIColor clearColor];
    ZSlider.value = 50;//当前的值                                                         //  添加事件
    [ZSlider addTarget:self action:@selector(ZChanged:) forControlEvents:UIControlEventValueChanged];
    [ZSlider addTarget:self action:@selector(ZInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ZSlider];
    
    riseDownSlider  = [[UISlider alloc] initWithFrame:CGRectMake(105,SCREEN_HEIGHT-85, 150, 20)];
    //设置未滑动位置背景图片
    [riseDownSlider setMinimumTrackImage:[UIImage imageNamed:@"main_slider_bg_1.png"] forState:UIControlStateNormal];
    //设置已滑动位置背景图
    [riseDownSlider setMaximumTrackImage:[UIImage imageNamed:@"main_slider_bg_1.png"] forState:UIControlStateNormal];
    //设置滑块图标图片
    [riseDownSlider setThumbImage:[UIImage imageNamed:@"main_slider_btn.png"] forState:UIControlStateNormal];
    //设置点击滑块状态图标
    [riseDownSlider setThumbImage:[UIImage imageNamed:@"main_slider_btn.png"] forState:UIControlStateHighlighted];
    
    riseDownSlider.transform =  CGAffineTransformMakeRotation( M_PI * 0.5 );
    riseDownSlider.minimumValue = 0.00;         //设置最小值
    riseDownSlider.maximumValue = 100.00;        //设置最大值
    riseDownSlider.backgroundColor=[UIColor clearColor];
    riseDownSlider.value = 50;//当前的值                                                         //  添加事件
    [riseDownSlider addTarget:self action:@selector(riseDownChanged:) forControlEvents:UIControlEventValueChanged];
    [riseDownSlider addTarget:self action:@selector(riseDownInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:riseDownSlider];
    
    
    lightSlider = [[UISlider alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-180)/2, 80, 180, 20)];
    lightSlider.minimumValue = 0; //设置最小值
    lightSlider.maximumValue = 0.8; //设置最大值
    lightSlider.value = 0.8;//当前的值
    lightSlider.hidden=YES;    //默认隐藏
    //    添加事件
    [lightSlider addTarget:self action:@selector(lightSliderChang:) forControlEvents:UIControlEventValueChanged];
    [lightSlider addTarget:self action:@selector(lightSliderInside:) forControlEvents:UIControlEventTouchUpInside];
    [lightSlider bringSubviewToFront:_showButton];
    [self.view addSubview:lightSlider];
    
}


#pragma mark View

-(void)dobotBgmHiddenMethod
{
    dobotBgm.hidden=YES;
}

-(void)powerIsChanged:(UISwitch *)paramSender{
    
    if([paramSender isOn]){    //如果开关状态为ON

        
    }else{
        
        [self stopPowerDobot];
    }
}

-(void)socketIsChanged:(UISwitch *)paramSender{
    
    
    if([paramSender isOn]){    //如果开关状态为ON
        
       // [self socketConnentToHost];
        
        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        theAnimation.duration=1.5;
        theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
        theAnimation.toValue=[NSNumber numberWithFloat:0.0];
        [dobotBgm.layer addAnimation:theAnimation forKey:@"animateOpacity"];
        
        [NSTimer scheduledTimerWithTimeInterval:theAnimation.duration
                                         target:self
                                       selector:@selector(dobotBgmHiddenMethod)
                                       userInfo:nil
                                        repeats:NO];
        
        
    }else{

      //  [self cutConnent];
        dobotBgm=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        dobotBgm.alpha=1;
        dobotBgm.image=[UIImage imageNamed:@"dobotBgm"];
        [self.view addSubview:dobotBgm];

    }
}

-(void)add_forWard_Back_left_rightView //前后左右
{
    //开启关闭动力
    UISwitch *powerSwitch=[[UISwitch alloc] initWithFrame:CGRectMake(90, 20, 0, 0)];
    [powerSwitch setOn:NO];
   [powerSwitch addTarget:self action:@selector(powerIsChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:powerSwitch];
    
    //socket开启关闭
    UISwitch *socketSwitch=[[UISwitch alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT/2-20, 20, 0)];
    [socketSwitch setOn:NO];
    [socketSwitch addTarget:self action:@selector(socketIsChanged:) forControlEvents:UIControlEventValueChanged];
   // [self.view addSubview:socketSwitch];
    
    UILabel *VideoLable=[[UILabel alloc] initWithFrame:CGRectMake(70, SCREEN_HEIGHT/2-20, 100, 30)];
    VideoLable.text=@"Video";
    VideoLable.textAlignment=NSTextAlignmentLeft;
    VideoLable.layer.cornerRadius=8;
    VideoLable.textColor=[UIColor whiteColor];
    VideoLable.layer.masksToBounds=YES;
   // [self.view addSubview:VideoLable];
    
    UILabel *powerLable=[[UILabel alloc] initWithFrame:CGRectMake(150, 20, 100, 30)];
    powerLable.text=@"Power";
    powerLable.textAlignment=NSTextAlignmentLeft;
    powerLable.layer.cornerRadius=8;
    powerLable.textColor=[UIColor whiteColor];
    powerLable.layer.masksToBounds=YES;
    [self.view addSubview:powerLable];
    
    UILabel *socketLable=[[UILabel alloc] initWithFrame:CGRectMake(300, 25, 100, 20)];
    socketLable.text=@"socket开关";
   // [self.view addSubview:socketLable];
    
    UIButton *riseButton=[UIButton buttonWithType:UIButtonTypeCustom];
    riseButton.frame=CGRectMake(180, SCREEN_HEIGHT-160, 60, 40);
    [riseButton setTitle:@"Rise" forState:UIControlStateNormal];
    [riseButton setTintColor:[UIColor whiteColor]];
    riseButton.backgroundColor=[UIColor clearColor];
    [self.view addSubview:riseButton];
    
    UIButton *downButton=[UIButton buttonWithType:UIButtonTypeCustom];
    downButton.frame=CGRectMake(180, SCREEN_HEIGHT-35, 60, 40);
    [downButton setTitle:@"Down" forState:UIControlStateNormal];
    [downButton setTintColor:[UIColor whiteColor]];
    downButton.titleLabel.font=[UIFont systemFontOfSize:16];
    downButton.backgroundColor=[UIColor clearColor];
    [self.view addSubview:downButton];
    
    _forWardButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _forWardButton.frame=CGRectMake(SCREEN_WIDTH-230, SCREEN_HEIGHT-95, 40, 40);
    [_forWardButton setTitle:@"Z" forState:UIControlStateNormal];
    [_forWardButton bringSubviewToFront:_showButton];
    _forWardButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [_forWardButton setTintColor:[UIColor whiteColor]];
    _forWardButton.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_forWardButton];
    
    _leftButton=[[UIButton alloc] initWithFrame:CGRectMake(20, (SCREEN_HEIGHT-40*2)/2+40, 40, 40)];
    [_leftButton setTitle:@"左" forState:UIControlStateNormal];
    [_leftButton bringSubviewToFront:_showButton];
    _leftButton.titleLabel.font=[UIFont systemFontOfSize:25];
    [_leftButton setTintColor:[UIColor whiteColor]];
    [_leftButton addTarget:self action:@selector(orientationOlayLeft) forControlEvents:UIControlEventTouchDown];
    [_leftButton addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
    _leftButton.backgroundColor=[UIColor grayColor];
//    [self.view addSubview:_leftButton];
    
    _rightButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, (SCREEN_HEIGHT-40*2)/2-30, 40, 40)];
    [_rightButton setTitle:@"右" forState:UIControlStateNormal];
    [_rightButton bringSubviewToFront:_showButton];
    _rightButton.titleLabel.font=[UIFont systemFontOfSize:25];
    [_rightButton setTintColor:[UIColor whiteColor]];
    [_rightButton addTarget:self action:@selector(orientationOlayRight) forControlEvents:UIControlEventTouchDown];
    [_rightButton addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
    _rightButton.backgroundColor=[UIColor grayColor];
 //   [self.view addSubview:_rightButton];
    
    _backButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, (SCREEN_HEIGHT-40*2)/2+40, 40, 40)];
    [_backButton setTitle:@"后" forState:UIControlStateNormal];
    [_backButton bringSubviewToFront:_showButton];
    _backButton.titleLabel.font=[UIFont systemFontOfSize:25];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton addTarget:self action:@selector(orientationOlayBack) forControlEvents:UIControlEventTouchDown];
    [_backButton addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
    _backButton.backgroundColor=[UIColor grayColor];
 //   [self.view addSubview:_backButton];
    
    UIButton *settingButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60*3-30, 20, 60, 30)];
    [settingButton setTitle:@"SetUp" forState:UIControlStateNormal];
    [settingButton bringSubviewToFront:_showButton];
    settingButton.layer.cornerRadius=8;
    settingButton.layer.masksToBounds=YES;
   // settingButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [settingButton setTintColor:[UIColor whiteColor]];
    [settingButton addTarget:self action:@selector(alert1) forControlEvents:UIControlEventTouchUpInside];
    settingButton.backgroundColor=[UIColor grayColor];
    [self.view addSubview:settingButton];
    
    sportModel=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 20, 200, 30)];
    sportModel.text=@"Model：Inching(Default)";
    sportModel.textColor=[UIColor whiteColor];
    [self.view addSubview:sportModel];
    
}

-(void)settingAction
{
    SettingViewController *set=[[SettingViewController alloc] init];
    [self presentViewController:set animated:YES completion:^{
        
    }];
}

//加载图像
-(void)addWebView
{
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _webView.delegate = self;
    //关闭webView的弹回效果
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    [self.view addSubview:_webView];
    
    NSString *outputHTML=[[NSString alloc] initWithFormat:@"<body style='margin: 0px; padding: 0px'><img width='%f' height='%f' src='http://192.168.8.1:8083/?action=stream'></body>",SCREEN_WIDTH,SCREEN_HEIGHT];
    //[_webView loadHTMLString:outputHTML baseURL:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
   // [_webView loadRequest:request];
    
    dobotBgm=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    dobotBgm.alpha=1;
    dobotBgm.image=[UIImage imageNamed:@"dobotBgm.jpg"];
    [self.view addSubview:dobotBgm];
    
    //遮罩，显示亮度
    self.lightView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.lightView.backgroundColor=[UIColor blackColor];
    self.lightView.alpha=0;
    [self.lightView bringSubviewToFront:dobotBgm];
    [self.view addSubview:_lightView];
    
}

-(void)addCarButtonAndDoBot             //机械臂和小车控制
{
    
    _CarView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-BigCircle_Size,BigCircle_Size , BigCircle_Size)];
    _CarView.backgroundColor=[UIColor greenColor];
    _CarView.layer.cornerRadius=BigCircle_Size/2;
    _CarView.layer.masksToBounds=YES;
    [self.view addSubview:_CarView];
    
    self.carButton=[[UIButton alloc] initWithFrame:CGRectMake(BigCircle_Size/2-(SmartCircle_Size)/2, BigCircle_Size/2-(SmartCircle_Size)/2, (SmartCircle_Size), (SmartCircle_Size))];
    [self.carButton addTarget:self action:@selector(dragCarMoving:withEvent: )forControlEvents: UIControlEventTouchDragInside];
    [self.carButton addTarget:self action:@selector(dragCarEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
     UIControlEventTouchUpOutside];
    self.carButton.layer.cornerRadius=(SmartCircle_Size)/2;
    self.carButton.layer.masksToBounds=YES;
    self.carButton.backgroundColor=[UIColor redColor];
    [_CarView addSubview:self.carButton];
    
    listButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 20, 60, 30)];
    [listButton setTitle:@"Menu" forState:UIControlStateNormal];
    [listButton bringSubviewToFront:_showButton];
    [listButton setTintColor:[UIColor whiteColor]];
    listButton.layer.cornerRadius=8;
    listButton.layer.masksToBounds=YES;
    [listButton addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    listButton.backgroundColor=[UIColor grayColor];
    [self.view addSubview:listButton];
    
    cameraButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 20, 60, 30)];
    [cameraButton setTitle:@"Camera" forState:UIControlStateNormal];
    [cameraButton bringSubviewToFront:_showButton];
    cameraButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [cameraButton setTintColor:[UIColor whiteColor]];
    cameraButton.layer.cornerRadius=8;
    cameraButton.layer.masksToBounds=YES;
    [cameraButton addTarget:self action:@selector(cameraAction) forControlEvents:UIControlEventTouchUpInside];
    cameraButton.backgroundColor=[UIColor grayColor];
    [self.view addSubview:cameraButton];
    
    lightButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, 20, 60, 30)];
    [lightButton setTitle:@"Light" forState:UIControlStateNormal];
    [lightButton bringSubviewToFront:_showButton];
    [lightButton setTintColor:[UIColor whiteColor]];
    lightButton.layer.cornerRadius=8;
    lightButton.layer.masksToBounds=YES;
    [lightButton addTarget:self action:@selector(lightAction) forControlEvents:UIControlEventTouchUpInside];
    lightButton.backgroundColor=[UIColor grayColor];
    [self.view addSubview:lightButton];
    
}

-(void)listViewShow     //菜单View
{
    listView=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-220, 50, 200, SCREEN_HEIGHT-200)];
    listView.hidden=YES;
    listView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:listView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, ((SCREEN_HEIGHT-200)-20*4)/5*1+0-10, 180, 20)];
    slider.minimumValue = 0; //设置最小值
    slider.maximumValue = 0.8; //设置最大值
    slider.value = 0;//当前的值
    //    添加事件
    [listView addSubview:slider];
    
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(10, ((SCREEN_HEIGHT-200)-20*4)/5*2+20-10, 180, 20)];
    [listView addSubview:slider1];
    
    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectMake(10, ((SCREEN_HEIGHT-200)-20*4)/5*3+40-10, 180, 20)];
    [listView addSubview:slider2];
    
    
    UISlider *dobotSpeed = [[UISlider alloc] initWithFrame:CGRectMake(10, ((SCREEN_HEIGHT-200)-20*4)/5*4+20*3-10, 180, 20)];
    dobotSpeed.minimumValue = 1.00;         //设置最小值
    dobotSpeed.maximumValue = 10.00;        //设置最大值
    dobotSpeed.value = changSpeed;//当前的值                                                         //  添加事件
    [dobotSpeed addTarget:self action:@selector(dobotSpeedChanged:) forControlEvents:UIControlEventValueChanged];
    [dobotSpeed addTarget:self action:@selector(dobotSpeedInside:) forControlEvents:UIControlEventTouchUpInside];
    [listView addSubview:dobotSpeed];
    
    NSArray *lableArr=@[@"小车前进速度",@"小车旋转速度",@"机械臂升降速度",@"机械臂运动速度"];
    for (int i=0; i<4; i++) {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(50, ((SCREEN_HEIGHT-200)-20*4)/5*(i+1)+20*i+10, 160, 20)];
        lable.text=lableArr[i];
        lable.backgroundColor=[UIColor clearColor];
        [listView addSubview:lable];
    }

}

#pragma  mark OtherMethod

-(void)coverViewButton                     //控制显示的按钮
{
    _showButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _showButton.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_showButton addTarget:self action:@selector(timeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.showButton bringSubviewToFront:_webView];
    [self.view addSubview:_showButton];
}

-(void)listAction                   //是否显示菜单
{
    
    if (_isShow==NO) {
        
        [self listViewShow];
        
        listView.hidden=NO;

        _isShow=YES;
        
    }else{
        
        listView.hidden=YES;
        
        _isShow=NO;
    }
    
}

-(void)lightAction               //调节亮度
{
    
    if (_isCheckLightChang==NO) {
        
        lightSlider.hidden=NO;    //默认隐藏
        _isCheckLightChang=YES;
    
    }else{

        lightSlider.hidden=YES;    //默认隐藏
        _isCheckLightChang=NO;
    }
    
}
#pragma mark UISliderMethod

//——————————————————————————————升降——————————————————————————————————————————

-(void)risetime:(NSTimer *)risetimer
{
    [self H_enumType:H_orientationOlayRise];
}

-(void)downtime:(NSTimer *)downtimer
{
    [self H_enumType:H_orientationOlayDown];
}

static bool isTime=YES;       //只发一次定时器

-(void)riseDownChanged:(UISlider *)slider      //机械臂运动速度
{
    //NSLog(@"changSpeed=%f",changSpeed);
    
    int i=(int)slider.value;
    
    if (i<50) {
        
        if (isTime==YES) {
            
          timeRiseDown =  [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(risetime:) userInfo:nil repeats:YES];
            isTime = NO;
        }
        
    }else if (i>50)
    {
        if (isTime==YES) {
            
            timeRiseDown =  [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(downtime:) userInfo:nil repeats:YES];
            isTime = NO;
        }

        
    }else if(i==50){
        
        
    }
    
}

-(void)riseDownInside:(UISlider *)slider
{
    
    riseDownChangedindex=slider.value;
    
    isTime=YES;                        //手指离开设置Yes
    
    [timeRiseDown invalidate];          //手指离开停止定时器，停止发送指令
    
    
    riseDownSlider.value = 50;
    
    //这只是界面滑块弹回的定时器，所有定时器用完注意停止定时。
  //  [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(riseDownChangedTimer:) userInfo:nil repeats:YES];
    
    
}

static int riseDownChangedindex;

-(void)riseDownChangedTimer:(NSTimer *)thetimer
{
    // NSLog(@"riseDownChangedindex=%d",riseDownChangedindex);
    
    if (riseDownChangedindex<50) {
        
        riseDownChangedindex++;
        
        //  NSLog(@"riseDownChangedindex=%d",riseDownChangedindex);
        
        riseDownSlider.value = riseDownChangedindex;//当前的值
        
        if (riseDownChangedindex==50) {
            
            [thetimer invalidate];
            
            
            riseDownChangedindex=0;
            
        }
        
    }else if(riseDownChangedindex>50)
    {
        riseDownChangedindex--;
        
        //   NSLog(@"Zvider=%d",riseDownChangedindex);
        
        riseDownSlider.value = riseDownChangedindex;//当前的值
        
        if (riseDownChangedindex==50) {
            
            [thetimer invalidate];
            
            riseDownChangedindex=0;
            
        }
        
    }else{
        
        [thetimer invalidate];
        
        riseDownChangedindex=0;
        
    }
    
    
}


//————————————————————————————————————————Z轴——————————————————————————————————

static float ZmoveSpeed=1.00;  //默认

-(void)ZChanged:(UISlider *)slider      //机械臂运动
{
    //NSLog(@"changSpeed=%f",changSpeed);
    
    ZmoveSpeed=slider.value;
    
    int i=(int)ZmoveSpeed;
    
    int k=1;
    
    if ((int)ZmoveSpeed<50) {
        
        k=(50-i)/5*(int)changSpeed;
        
        [self dobotUpLoadState:7 withAxis:6 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:(float)k withEndVel:0 withMaxVe:0];
        
    }else if ((int)ZmoveSpeed>50)
    {
        k=(i-50)/5*(int)changSpeed;
        
        [self dobotUpLoadState:7 withAxis:5 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:(float)k withEndVel:0 withMaxVe:0];
        
    }else if((int)ZmoveSpeed==50){
        
        k=1*(int)changSpeed;
        
        [self dobotUpLoadState:7 withAxis:0 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:0 withEndVel:0 withMaxVe:0];
        
    }
    
    NSLog(@"k=%d",k);
    
    // NSLog(@"Changedslider.Value=%f",slider.value);
    
}
-(void)ZInside:(UISlider *)slider
{
   // Zvider=slider.value;
    
    ZSlider.value=50;
    
   // [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(SliderTimer:) userInfo:nil repeats:YES];
    
    [self dobotUpLoadState:7 withAxis:0 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:0 withEndVel:0 withMaxVe:0];
    
}
static int Zvider;

-(void)SliderTimer:(NSTimer *)thetimer
{
   // NSLog(@"Zvider=%d",Zvider);
    
    if (Zvider<50) {
        
        Zvider++;
        
      //  NSLog(@"Zvider=%d",Zvider);
        
        ZSlider.value = Zvider;//当前的值
        
        if (Zvider==50) {
            
            [thetimer invalidate];
            
            NSLog(@"停了");
            
            Zvider=0;
            
        }
        
    }else if(Zvider>50)
    {
        Zvider--;
        
      //  NSLog(@"Zvider=%d",Zvider);
        
        ZSlider.value = Zvider;//当前的值
        
        if (Zvider==50) {
            
            [thetimer invalidate];
            
            NSLog(@"停了");
            
            Zvider=0;
            
        }
        
    }else{
        
        [thetimer invalidate];
        
        NSLog(@"停了");
        
        Zvider=0;
        
    }
    
    //    NSLog(@"Zvider=%f",Zvider);
    //    ZSlider.value = Zvider;//当前的值
}

//————————————————————————————————————机械臂运动速度——————————————————————————————

static float changSpeed=1.00;   //默认

-(void)dobotSpeedChanged:(UISlider *)slider //机械臂运动速度，速度比例1～100，最小1/10*1/10，最大10/10*10/10;
{
    changSpeed=slider.value;
    
}

-(void)dobotSpeedInside:(UISlider *)slider
{
    
}

//————————————————————————————————————————屏幕亮度——————————————————————————————————

- (void)lightSliderChang:(UISlider *)slider
{
    
    _lightView.alpha=0.8-slider.value;
    
}
- (void)lightSliderInside:(UISlider *)slider
{
    
}

-(void)cameraAction         //拍照保存到本地
{
    
    //使用系统声音
    SystemSounds *sys=[[SystemSounds alloc] init];
    [sys initSystemSoundWithName:@"photoShutter" SoundType:@"caf"];
    [sys play];
    
    //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    //renderInContext呈现接受者及其子范围到指定的上下文
    [dobotBgm.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //返回一个基于当前图形上下文的图片
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //移除栈顶的基于当前位图的图形上下文
    UIGraphicsEndImageContext();
    
    //然后将该图片保存到图片图
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
}
-(void)motionAction         //加速计
{
    _motionManager = [[CMMotionManager alloc]init];
    
    if (_motionManager.accelerometerAvailable) {
        //判断硬件是否可使用加数计
        [_motionManager setAccelerometerUpdateInterval:1/60.f];
        //使用push方式
        NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];
        [_motionManager startAccelerometerUpdatesToQueue:operationQueue withHandler:^(CMAccelerometerData *accelData,NSError *error){
          //  [self doAccess:accelData.acceleration];
        }];
    }else{
        
        NSLog(@"加速计不可用");
    }
}

#pragma mark Car_Method

-(void)forWardtime
{
    [self H_enumType:H_orientationOlayForWard];
}
-(void)backtime
{
    [self H_enumType:H_orientationOlayBack];
}
-(void)lefttime
{
    [self H_enumType:H_orientationOlayLeft];
}
-(void)righttime
{
    [self H_enumType:H_orientationOlayRight];

}
static bool forwardtime=YES;
static bool backtime=YES;
static bool lefttime=YES;
static bool righttime=YES;

- (void) dragCarMoving: (UIControl *) c withEvent:ev
{
    c.center = [[[ev allTouches] anyObject] locationInView:_CarView];
    
//    NSLog(@"c.center.x=%f",c.center.x);
//    NSLog(@"c.center.y=%f",c.center.y);
    
    //前进
    if (((int)c.center.x>45&&(int)c.center.x<105)&&((int)c.center.y<75)&&(int)c.center.y>0) {
        
        NSLog(@"前进");
        
        //使用定时器，让它0.2秒发一次
        
        [backCtrtime invalidate];
        [leftCtrtime invalidate];
        [rightCtrtime invalidate];
    
        
        if (forwardtime==YES) {
            
            
            forwardCtrtime = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(forWardtime) userInfo:nil repeats:YES];
            
            forwardtime = NO;
            
            backtime=YES;
            lefttime=YES;
            righttime=YES;
    
            
        }
        
        
    
    }
    
    //后退
   else if (((int)c.center.x>45&&(int)c.center.x<105)&&((int)c.center.y>75)&&(int)c.center.y<150) {
        
        NSLog(@"后退");
       
       [forwardCtrtime invalidate];
       [leftCtrtime invalidate];
       [rightCtrtime invalidate];
       
       if (backtime==YES) {
           
           backCtrtime = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(backtime) userInfo:nil repeats:YES];
           
           backtime = NO;
           
           forwardtime=YES;
           lefttime=YES;
           righttime=YES;
       }

       
       
        
    }
    //左转
    
  else  if (((int)c.center.y>45&&(int)c.center.y<105)&&((int)c.center.x<75)&&(int)c.center.x>0) {
        
        NSLog(@"左转");
      
      [forwardCtrtime invalidate];
      [backCtrtime invalidate];
      [rightCtrtime invalidate];
      
      if (lefttime==YES) {
          
          leftCtrtime = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(lefttime) userInfo:nil repeats:YES];
          
          lefttime = NO;
          
          forwardtime=YES;
          backtime=YES;
          righttime=YES;
      }

      
      
        
    }
    //右转
    
   else if (((int)c.center.y>45&&(int)c.center.y<105)&&((int)c.center.x>75)&&(int)c.center.x<150) {
        
        NSLog(@"右转");
       
       [forwardCtrtime invalidate];
       [backCtrtime invalidate];
       [leftCtrtime invalidate];
       
       if (righttime==YES) {
           
           rightCtrtime = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(righttime) userInfo:nil repeats:YES];
           
           righttime = NO;
           
           forwardtime=YES;
           backtime=YES;
           lefttime=YES;

       }
        
    }
    
}

- (void) dragCarEnded: (UIControl *) c withEvent:ev
{
    
    forwardtime=YES;
    backtime=YES;
    lefttime=YES;
    righttime=YES;
    
    //定时器注意停止，否则好危险
    
    [forwardCtrtime invalidate];
    [backCtrtime invalidate];
    [leftCtrtime invalidate];
    [rightCtrtime invalidate];
    
    
    c.center = [[[ev allTouches] anyObject] locationInView:_CarView];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect frame = self.carButton.frame;
        
        frame.origin.x =BigCircle_Size/2-SmartCircle_Size/2;
        frame.origin.y =BigCircle_Size/2-SmartCircle_Size/2;
        
        self.carButton.frame = frame;
        
    }];
    
}

#pragma mark  ScoketMethod

-(void)socketConnentToHost;        //socket连接
{
    
    _socket=[[AsyncSocket alloc] initWithDelegate:self];
    if (![_socket isConnected]) {
//        [_socket connectToHost:HOST onPort:PORT error:nil];
//        [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//        [_socket writeData:[@"" dataUsingEncoding:NSUTF8StringEncoding]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
    }
    [timer invalidate];
    
}

-(void)cutConnent;                 //断开连接
{
    _socket.userData = SocketOfflineByUser;// 声明是由用户主动切断
    [timer invalidate];
    [_socket disconnect];
}

#pragma mark dobotPowerMethod

-(void)H_enumType:(H_DoBotDataCmd)H_type             //选择操作类型
{
    
    DobotPowerCmdData *dobotData=[[DobotPowerCmdData alloc] init];
    
    switch (H_type) {
            
        case H_startPower:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:startPower]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
            
            break;
        case H_stopPower:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:stopPower]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
//            
            break;
        case H_detectionPower:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:detectionPower]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
            
            break;
        case H_orientationDisChang:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:orientationDisChang]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
            
            break;
        case H_orientationOlayRight:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:orientationOlayRight]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
//            
            break;
        case H_orientationOlayLeft:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:orientationOlayLeft]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
//            
            break;
        case H_orientationOlayForWard:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:orientationOlayForWard]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
            
            break;
        case H_orientationOlayBack:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:orientationOlayBack]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
//            
            break;
        case H_orientationOlayRise:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:orientationOlayRise]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
//            
            break;
        case H_orientationOlayDown:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:orientationOlayDown]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
            
            break;
        case H_intoCheckSumStandardModel:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:intoCheckSumStandardModel]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
//            
            break;
        case H_outCheckSumStandardModel:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:outCheckSumStandardModel]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
            
            break;
        case H_parameterRead:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:parameterRead]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
            
            break;
        case H_parameterWrite:
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithType:parameterWrite]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
            
            break;
            
        case H_DobotPowerStop:                                 //机械臂停止
            
//            [_socket readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
//            
//            [_socket writeData:[dobotData powerDataWithDoBotType:DobotPowerStop]  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
            
            break;
            
        default:
            break;
    }
    
}

-(void)stopAction   //停止操作
{
   // [timeRiseDown invalidate];
}

-(void)startPowerDobot;           //开启动力
{
    
    [self H_enumType:H_startPower];
    
}

-(void)stopPowerDobot;            //关闭动力
{
    [self H_enumType:H_stopPower];
}

-(void)detectionPower; //通信检测
{
   [self H_enumType:H_detectionPower];
}

-(void)orientationDisChang;  //方向不变
{
    [self H_enumType:H_orientationDisChang];
}

-(void)orientationOlayRight;   //方向仅仅右转
{
    [self H_enumType:H_orientationOlayRight];
}

-(void)orientationOlayLeft;    //方向仅仅左转
{
    [self H_enumType:H_orientationOlayLeft];
}

-(void)orientationOlayForWard;  //只前进
{
    
    [self H_enumType:H_orientationOlayForWard];
    
}

-(void)orientationOlayBack;    //只后退
{
    
    [self H_enumType:H_orientationOlayBack];
}

-(void)orientationOlayRise;   //只上升
{
  // timeRiseDown = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(RiseTime)  userInfo:nil repeats:YES];
    
}
-(void)RiseTime
{
    [self H_enumType:H_orientationOlayRise];
    
}

-(void)orientationOlayDown;   //只下降
{
  //  timeRiseDown = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(DownTime)  userInfo:nil repeats:YES];
}
-(void)DownTime
{
    [self H_enumType:H_orientationOlayDown];
}

-(void)intoCheckSumStandardModel;       //进入校准模式,关闭动力
{
    [self H_enumType:H_stopPower];    //先关闭动力，再进入
    
    [self H_enumType:H_intoCheckSumStandardModel];
    
}
-(void)outCheckSumStandardModel;       //退出校准模式
{
    [self H_enumType:H_outCheckSumStandardModel];
    
    [self H_enumType:H_startPower];     //退出,开启动力
}

-(void)parameterRead;            //参数读取
{
    [self H_enumType:H_parameterRead];
}
-(void)parameterWrite;            //参数写入默认
{
    [self H_enumType:H_parameterWrite];
}


-(void)dobotUpLoadState:(float)state withAxis:(float)Axis withX:(float)X withY:(float)Y withZ:(float)Z withRHead:(float)RHead withIsGrab:(float)isGrab withStartVe:(float)StartVe withEndVel:(float)EndVel withMaxVe:(float)MaxVe;                //机械臂下发，模式
{
    
    stufloatAll.state=state;
    stufloatAll.axis=Axis;
    stufloatAll.x=X;
    stufloatAll.y=Y;
    stufloatAll.z=Z;
    stufloatAll.RHead=RHead;
    stufloatAll.isGrab=isGrab;
    stufloatAll.StartVe=StartVe;
    stufloatAll.EndVel=EndVel;
    stufloatAll.MaxVe=MaxVe;
    
    uint8_t sendBuffer[48] ={0};
    
    sendBuffer[0] = 0x55;
    sendBuffer[1] = 0x30;
    sendBuffer[2] = 0x10;
    sendBuffer[3] = 0x05;
    
    sendBuffer[4] = 0x21;
    sendBuffer[5] = 0xa5;
    sendBuffer[46]=0x5a;

    memcpy(sendBuffer+6, &stufloatAll, sizeof stufloatAll);
    
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    
    NSData *theData = [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];
    NSLog(@"theData=%@",theData);
    
    //[_socket writeData:theData  withTimeout:WRITEDATAWITHTIMEOUT tag:TAG];
    
}


#pragma mark TheAnimationAction

//执行动画，消失其它控件，只显示webView
-(void)theAnimationAction:(float)theTime
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=theTime;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.5];
    theAnimation.toValue=[NSNumber numberWithFloat:0.0];
    [_CarView.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    [listButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    [cameraButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    [lightButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    [_DoBotView.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    
    [NSTimer scheduledTimerWithTimeInterval:theAnimation.duration
                                     target:self
                                   selector:@selector(targetMethod)
                                   userInfo:nil
                                    repeats:NO];
    
}
-(void)targetMethod
{
    
   // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    _CarView.hidden=YES;
    listButton.hidden=YES;
    cameraButton.hidden=YES;
    lightButton.hidden=YES;
    _DoBotView.hidden=YES;
    
    _isShowOtherView=NO;
    
}
-(void)timeAction                   //是否显示其它按钮
{
    
    if (_isShowOtherView==NO) {
        
        _CarView.hidden=YES;
        listButton.hidden=YES;
        cameraButton.hidden=YES;
        lightButton.hidden=YES;
        listView.hidden=YES;
        lightSlider.hidden=YES;
        _DoBotView.hidden=YES;
        
   //     [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        
        _isShowOtherView=YES;
        
    }else{
        
     //   [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        
        _DoBotView.hidden=NO;
        
        [self addCarButtonAndDoBot];
    
        _isShowOtherView=NO;
        
    }
    
    
}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView;
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    NSLog(@"webViewDidFinishLoad");
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=1.5;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.0];
    [dobotBgm.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    
    [NSTimer scheduledTimerWithTimeInterval:theAnimation.duration
                                            target:self
                                          selector:@selector(dobotBgmHiddenMethod)
                                          userInfo:nil
                                           repeats:NO];
    

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error;
{
    //NSLog(@"error=%@",error);
    dobotBgm.hidden=NO;
}

#pragma mark AsyncSocketDelegate

- (BOOL)onSocketWillConnect:(AsyncSocket *)sock;
{
    return YES;
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port;
{
    //NSLog(@"host=%@,port=%hu",host,port);
    
}

static NSString *adataString=@"";

- (NSString *)stringFromHexString:(NSString *)hexString {     // ASCLL十六进制转换为普通字符串。
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    
    NSLog(@"------字符串-------%@",unicodeString);
    
    //1.连接字符长度
    
    adataString = [adataString stringByAppendingString:unicodeString];
    
    NSLog(@"adataString_________=%@",adataString);
    
    //2.截取34位字符，并转十进制字符
    
    if (adataString.length>4) {                     //当adataString长度大于4时开始做处理
        
        //十六进制的十进制值,计算字节的长度
        unsigned long int BufferLenght = strtoul([[adataString substringWithRange:NSMakeRange(2, 2)] UTF8String],0,16);
        
        NSLog(@"BufferLenght=%lu",BufferLenght);
        
        //最后一个字节的十进制数值
        unsigned long int lastLenght = strtoul([[adataString substringWithRange:NSMakeRange(adataString.length-2, 2)] UTF8String],0,16);
        NSLog(@"lastLenght=%lu",lastLenght);
        
        //3.计算长度，adataString的长度与theLenght比较
        
        if (BufferLenght==adataString.length/2) {            //返回包的已全部返回
            
            NSLog(@"已经全部返回数据");
            
          // unsigned long int k= adataString.length/2;
            
            int i =(int) adataString.length/2-1;

            //4.进行校验
            uint8_t buffer[i];
            
            for (int i =0; i < adataString.length; i+=2) {
                
                NSString *strByte = [adataString substringWithRange:NSMakeRange(i,2)];
                unsigned long red = strtoul([strByte UTF8String],0,16);
                Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
                buffer[i/2+0] = b;
                
            }
            
            NSString *hexString = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",crc8(buffer, sizeof(buffer))]];
            
            NSLog(@"hexString2=%@",hexString);
            
            
            //校验后的十进制数值
            unsigned long int checkLenght= strtoul([[hexString substringWithRange:NSMakeRange(0, 2)] UTF8String],0,16);
            
            NSLog(@"checkLenght=%lu",checkLenght);
            
            
            if (lastLenght==checkLenght) {             //数值想等，返回正确的数据包
                
                NSLog(@"校验想等，返回正确");
                
            }else{
                
                                                    //数据包返回，错误
            }
            
            //5.不管校验成不成功，必须清空前一条数据
            
            adataString=@"";                             //清空内容，保存对象。
            
            NSLog(@"adataString=%@",adataString);
    
            
        }else{                                           //还没全返回
            
            //请求超时处理
            
            //等待500毫秒，不来就清除adataString
            
            // [self performSelector:@selector(deleteStr) withObject:self afterDelay:0.5];
            
        }
        
    }
    
    return unicodeString;
    
}

-(void)deleteStr
{
    adataString=@"";
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;
{
    
  //  [sock readDataWithTimeout:READDATAWITHTIMEOUT tag:TAG];
    
    NSString *message=[[NSString alloc] initWithFormat:@"%@",data];
    
    NSLog(@"theData=%@",data);
 
    message=[[[message stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (message.length!=0) {
        
       // [self stringFromHexString:message];
        
    }
    
    //NSLog(@"message=%@",message);
    
   // NSLog(@"data=%@",message);
    
    //[Arr addObject:message];
    
//    NSString *messageStr = [Arr componentsJoinedByString:@""];
//    
//    messageStr=[messageStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
   // NSLog(@"messageStr=%@",messageStr);
    
    
}


- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag;
{
    
   // NSLog(@"didWriteDataWithTag");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock;
{
    NSLog(@"onSocketDidDisconnect");
    
    if (![_socket isConnected]) {
        
        if (_socket.userData==SocketOfflineByServer) {     //如果是服务端主动掉线则重连
            
            //每30秒发送一个心跳包,告诉服务器客户端还在哦
            timer=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(socketConnentToHost) userInfo:nil repeats:YES];
            
        }else if(_socket.userData==SocketOfflineByUser){    //客户端主动掉线

            //每30秒发送一个心跳包,告诉服务器客户端还在哦
            timer=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(socketConnentToHost) userInfo:nil repeats:YES];
            
        }
    
        
    }
   
    //[self socketConnentToHost];
    
}

#pragma mark XYViewClassDelegate

static float XmoveSpeed=1.00;  //默认
static float YmoveSpeed=1.00;  //默认

//XY的值
- (void)theX:(float)x andY:(float)y andRequest:(XYView *)XYClass;
{
    NSLog(@"X=%f,Y=%f",x,y);
        
        XmoveSpeed=x;
        YmoveSpeed=y;
    
        int i=(int)XmoveSpeed;
        int j=(int)YmoveSpeed;
        
        int k=1;
    
        if (i==75) {                 //X轴不变，动的是Y轴
            
            if ((int)YmoveSpeed<75) {
                
                k=(75-j)/7*(int)changSpeed;
                
                [self dobotUpLoadState:2 withAxis:4 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:(float)k withEndVel:0 withMaxVe:0];
                
            }else if ((int)YmoveSpeed>75)
            {
                k=(j-75)/7*(int)changSpeed;
                
                [self dobotUpLoadState:2 withAxis:3 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:(float)k withEndVel:0 withMaxVe:0];
                
            }else if((int)YmoveSpeed==75){
                
                k=1*(int)changSpeed;
                
                [self dobotUpLoadState:2 withAxis:0 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:0 withEndVel:0 withMaxVe:0];
                
            }

            
        }else if(j==75)              //Y轴不变，动的是X轴
        {
            if ((int)XmoveSpeed<75) {
                
                k=(75-i)/7*(int)changSpeed;
                
                [self dobotUpLoadState:7 withAxis:2 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:(float)k withEndVel:0 withMaxVe:0];
                
            }else if ((int)XmoveSpeed>75)
            {
                k=(i-75)/7*(int)changSpeed;
                
                [self dobotUpLoadState:7 withAxis:1 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:(float)k withEndVel:0 withMaxVe:0];
                
            }else if((int)XmoveSpeed==75){
                
                k=1*(int)changSpeed;
                
                [self dobotUpLoadState:7 withAxis:0 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:0 withEndVel:0 withMaxVe:0];
                
            }

        }
    
        NSLog(@"k=%d",k);

    
}

//返回手势离开
- (void)InsideMethod:(XYView *)XYInside;
{
    NSLog(@"离开");
    
    [self dobotUpLoadState:7 withAxis:0 withX:0 withY:0 withZ:0 withRHead:0 withIsGrab:0 withStartVe:0 withEndVel:0 withMaxVe:0];
    
}


-(void)checkSum          //CRC8校验
{
    uint8_t sendBuffer[6] = {0x55,0x07,0x10,0x01,0x11,0x01};
    
    NSString *hexString = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",crc8(sendBuffer, sizeof(sendBuffer))]];
    
   // NSLog(@"hexString=%@",hexString);
    
}
-(void)alert
{
    
    listView=[[UIView alloc] initWithFrame:CGRectMake(10, 10, 250, 250)];
    listView.backgroundColor=[UIColor clearColor];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, (250-20*4)/5, 220, 20)];
    slider.minimumValue = 0; //设置最小值
    slider.maximumValue = 0.8; //设置最大值
    slider.value = 0;//当前的值
    //    添加事件
    [listView addSubview:slider];
    
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(10, (250-20*4)/5*2+20-10, 220, 20)];
    [listView addSubview:slider1];
    
    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectMake(10, (250-20*4)/5*3+40-10, 220, 20)];
    [listView addSubview:slider2];
    
    
    UISlider *dobotSpeed = [[UISlider alloc] initWithFrame:CGRectMake(10, (250-20*4)/5*4+20*3-10, 220, 20)];
    dobotSpeed.minimumValue = 1.00;         //设置最小值
    dobotSpeed.maximumValue = 10.00;        //设置最大值
    dobotSpeed.value = changSpeed;//当前的值                                                         //  添加事件
    [dobotSpeed addTarget:self action:@selector(dobotSpeedChanged:) forControlEvents:UIControlEventValueChanged];
    [dobotSpeed addTarget:self action:@selector(dobotSpeedInside:) forControlEvents:UIControlEventTouchUpInside];
    [listView addSubview:dobotSpeed];
    
    NSArray *lableArr=@[@"CarForwardSpeed",@"CarsPinningSpeed",@"RiseDownSpeed",@"DobotSportSpeed"];
    for (int i=0; i<4; i++) {
        if (i==0) {
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(50, (250-20*4)/5*(i+1)+20*i+10+10, 160, 20)];
            lable.text=lableArr[i];
            lable.backgroundColor=[UIColor clearColor];
            [listView addSubview:lable];
        }
        else{
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(50, (250-20*4)/5*(i+1)+20*i+10, 160, 20)];
            lable.text=lableArr[i];
            lable.backgroundColor=[UIColor clearColor];
            [listView addSubview:lable];
        }
    }

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert.view addSubview:listView];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
    
}
-(void)alert1
{
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction1 = [UIAlertAction actionWithTitle:@"Mouse Control" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        sportModel.text=@"Model:Mouse Control";
        
    }];
    
    UIAlertAction *sureAction2 = [UIAlertAction actionWithTitle:@"Iching(Default)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        sportModel.text=@"Model:Iching(Default)";
    }];
    UIAlertAction *sureAction3= [UIAlertAction actionWithTitle:@"Visual Patterns" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        sportModel.text=@"Model:Visual Patterns";
        
    }];
    UIAlertAction *sureAction4 = [UIAlertAction actionWithTitle:@"Writing Meander" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        sportModel.text=@"Model:Writing Meander";
        
    }];
    UIAlertAction *sureAction5 = [UIAlertAction actionWithTitle:@"Voice Control" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sportModel.text=@"Model:Voice Control";
        
    }];
    UIAlertAction *sureAction6 = [UIAlertAction actionWithTitle:@"Teach Mode" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        sportModel.text=@"Model:Teach Mode";
        
    }];
    UIAlertAction *sureAction7 = [UIAlertAction actionWithTitle:@"Absolute Coordinates Inching" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       sportModel.text=@"Model:Absolute Coordinates Inching";
        
    }];
    UIAlertAction *sureAction8 = [UIAlertAction actionWithTitle:@" Leap Motion Control" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        sportModel.text=@"Model:Leap Motion Control";
        
    }];
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    //    把事件添加到控制器
  //  [alertViewCtr addAction:cancelAction];
    [alertViewCtr addAction:sureAction1];
    [alertViewCtr addAction:sureAction2];
    [alertViewCtr addAction:sureAction3];
    [alertViewCtr addAction:sureAction4];
    [alertViewCtr addAction:sureAction5];
    [alertViewCtr addAction:sureAction6];
    [alertViewCtr addAction:sureAction7];
    [alertViewCtr addAction:sureAction8];
    
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^{
        
    }];

}
-(void)checkDoBotModel:(UIButton *)sender
{
    
}
//当内存发生警告时调用此方法释放内存
- (void)viewDidUnload
{
    
    [super viewDidUnload];
    
    self.carButton=nil;
    self.dobotButton=nil;
    self.boolButton=nil;
    self.showButton=nil;
    _CarView=nil;
    self.webView=nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

@end
