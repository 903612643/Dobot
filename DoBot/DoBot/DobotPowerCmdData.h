//
//  DobotPowerCmdData.h
//  DoBot
//
//  Created by 羊德元 on 16/7/28.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CarCtrDataCmd) {       //小车控制枚举
    
    startPower = 0, //开启动力
    stopPower, //关闭动力
    detectionPower, //通信检测
    
    orientationDisChang,      //方向不变
    orientationOlayRight,      //方向仅仅右转
    orientationOlayLeft,       //方向仅仅左转
    orientationOlayForWard,    //只前进
    orientationOlayBack,       //只后退
    orientationOlayRise,       //只上升
    orientationOlayDown,       //只下降
    
    intoCheckSumStandardModel,       //进入校准模式
    outCheckSumStandardModel,        //退出校准模式
    
    parameterRead,             //参数读取
    parameterWrite,            //参数写入默认
    
    
};

typedef NS_ENUM(NSUInteger, DoBotPowerDataCmd) {       //机械臂控制枚举
    
    //拖动模式 01
    
    //单轴点动模式  02
    inchingDobotPower=0,         //机械臂上传
    
    //视觉模式
    
    //写字激光雕刻模式
    
    //语音控制模式
    
    //示教模式
    
    //坐标系电动模式
    
    //体感控制模式
    
    //参数配置
    
    //示教参数配置模式
    
    //按键抬起 state=0
    
    DobotPowerStop,                 //机械臂停止
    
};


@interface DobotPowerCmdData : NSObject


-(NSData *)powerDataWithType:(CarCtrDataCmd)type;    //DoBotDataCmd 返回一个小车控制动力类型

-(NSData *)powerDataWithDoBotType:(DoBotPowerDataCmd)type;    //DoBotPowerDataCmd 返回一个机械臂控制动力类型

-(NSData *)startPowerData;  //开启动力
-(NSData *)stopPowerData;   //关闭动力

-(NSData *)detectionPowerData; //通信检测

-(NSData *)orientationDisChangData;  //方向不变
-(NSData *)orientationOlayRightData;   //方向仅仅右转
-(NSData *)orientationOlayLeftData;    //方向仅仅左转
-(NSData *)orientationOlayForWardData;  //只前进
-(NSData *)orientationOlayBackData;    //只后退
-(NSData *)orientationOlayRiseData;   //只上升
-(NSData *)orientationOlayDownData;   //只下降

-(NSData *)intoCheckSumStandardModelData;       //进入校准模式
-(NSData *)outCheckSumStandardModelData;        //退出校准模式

-(NSData *)parameterReadData;             //参数读取命令
-(NSData *)parameterWriteData;            //参数写入命令默认




-(NSData *)DobotPowerStop;                //机械臂停止


uint8_t crc8(uint8_t *p, uint8_t len);      //校验函数


@end
