//
//  DobotPowerCmdData.m
//  DoBot
//
//  Created by 羊德元 on 16/7/28.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import "DobotPowerCmdData.h"

@implementation DobotPowerCmdData


-(NSData *)powerDataWithType:(CarCtrDataCmd)type;         //动力类型
{
    
    NSData *tempData=nil;
    
    switch (type) {
            
        case startPower:
            
            tempData = [self startPowerData];
            
          break;
            
        case stopPower:
          
            tempData = [self stopPowerData];
            
            break;
            
        case detectionPower:
            
            tempData = [self detectionPowerData];
            
            break;
        case orientationDisChang:
            
            tempData = [self orientationDisChangData];
            
            break;
        case orientationOlayRight:
            
            tempData = [self orientationOlayRightData];
            
            break;
        case orientationOlayLeft:
            
            tempData = [self orientationOlayLeftData];
            
            break;
        case orientationOlayForWard:
            
            tempData = [self orientationOlayForWardData];
            
            break;
        case orientationOlayBack:
            
            tempData = [self orientationOlayBackData];
            
            break;
        case orientationOlayRise:
            
            tempData = [self orientationOlayRiseData];
            
            break;
        case orientationOlayDown:
            
            tempData = [self orientationOlayDownData];
            
            break;
        case intoCheckSumStandardModel:
            
            tempData = [self intoCheckSumStandardModelData];
            
            break;
        case outCheckSumStandardModel:
            
            tempData = [self outCheckSumStandardModelData];
            
            break;
        case parameterRead:
            
            tempData = [self parameterReadData];
            
            break;
        case parameterWrite:
            
            tempData = [self parameterWriteData];
            
            break;
                    
        default:
            break;
    }
    
    NSLog(@"tmepData=%@",tempData);
    
    return tempData;
    
}

-(NSData *)powerDataWithDoBotType:(DoBotPowerDataCmd)type;

//DoBotPowerDataCmd 返回一个机械臂控制动力类型

{
    NSData *tempData=nil;
    
    switch (type) {
            
        case inchingDobotPower:
            
            tempData = [self dobotUpLoadData]; //机械臂上传
            
            break;
        case DobotPowerStop:
            
            tempData = [self DobotPowerStop]; //机械臂停止
            
            break;
            
        default:
            break;
    }
    
    NSLog(@"tmepData=%@",tempData);
    
    return tempData;

}

#pragma mark CarPowerCmdDataMethod

-(NSData *)startPowerData   //开启动力
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x01,0x00};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];
}

-(NSData *)stopPowerData   //关闭动力
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x01,0x01};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];
    
}

-(NSData *)detectionPowerData; //通信检测
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x00,0x00};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];

}

-(NSData *)orientationDisChangData;  //方向不变
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x11,0x00};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];

}
-(NSData *)orientationOlayRightData;   //方向仅仅右转
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x11,0x10};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];

}
-(NSData *)orientationOlayLeftData;    //方向仅仅左转

{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x11,0x20};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];

}
-(NSData *)orientationOlayForWardData;  //只前进
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x11,0x04};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];

}
-(NSData *)orientationOlayBackData;    //只后退
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x11,0x08};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];

}
-(NSData *)orientationOlayRiseData;   //只上升
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x11,0x40};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];

}

-(NSData *)orientationOlayDownData;   //只下降
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0x11,0x80,0xe0};
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];

}

-(NSData *)intoCheckSumStandardModelData;       //进入校准模式
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0xe0,0x00};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];
}
-(NSData *)outCheckSumStandardModelData;        //退出校准模式
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0xe0,0x01};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];
}

-(NSData *)parameterReadData;             //参数读取命令
{
    uint8_t sendBuffer[7] = {0x55,0x07,0x10,0x00,0xe1,0x00};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];
}
-(NSData *)parameterWriteData;            //参数写入命令  默认  speed 5 5 5
{
    uint8_t sendBuffer[14] = {0x55,0x0e,0x10,0x00,0xe2,0x00,0x05,0x05,0x05,0x00,0x00,0x00,0x00};
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];
}

#pragma mark DobotPowerCmdDataMethod

-(NSData *)dobotUpLoadData;                //机械臂上传
{
    uint8_t sendBuffer[48] =
    {
        0x55,0x30,0x10,0x00,0x20,0xa5,0x02,0x03,0x04,0x05,
        0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
        0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,
        0x1A,0x1B,0x1C,0x1D,0x1E,0x1F,0x20,0x21,0x22,0x23,
        0x24,0x25,0x26,0x27,0x28,0x29,0x5a,0x5f
    };
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];
}

-(NSData *)DobotPowerStop;                //机械臂停止
{
    uint8_t sendBuffer[48] =
    {
        0x55,0x30,0x10,0x00,0x20,0xa5,0x00,0x03,0x04,0x05,
        0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
        0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,
        0x1A,0x1B,0x1C,0x1D,0x1E,0x1F,0x20,0x21,0x22,0x23,
        0x24,0x25,0x26,0x27,0x28,0x29,0x5a
    };
    sendBuffer[(sizeof sendBuffer) -1] = crc8(sendBuffer, sizeof(sendBuffer)-1);
    return [NSData dataWithBytes:&sendBuffer length:sizeof(sendBuffer)];
}

static const uint8_t crc_table[] = {          //CRC8校验查表法
    
    0x00, 0x07, 0x0e, 0x09, 0x1c, 0x1b, 0x12, 0x15, 0x38, 0x3f, 0x36, 0x31,
    0x24, 0x23, 0x2a, 0x2d, 0x70, 0x77, 0x7e, 0x79, 0x6c, 0x6b, 0x62, 0x65,
    0x48, 0x4f, 0x46, 0x41, 0x54, 0x53, 0x5a, 0x5d, 0xe0, 0xe7, 0xee, 0xe9,
    0xfc, 0xfb, 0xf2, 0xf5, 0xd8, 0xdf, 0xd6, 0xd1, 0xc4, 0xc3, 0xca, 0xcd,
    0x90, 0x97, 0x9e, 0x99, 0x8c, 0x8b, 0x82, 0x85, 0xa8, 0xaf, 0xa6, 0xa1,
    0xb4, 0xb3, 0xba, 0xbd, 0xc7, 0xc0, 0xc9, 0xce, 0xdb, 0xdc, 0xd5, 0xd2,
    0xff, 0xf8, 0xf1, 0xf6, 0xe3, 0xe4, 0xed, 0xea, 0xb7, 0xb0, 0xb9, 0xbe,
    0xab, 0xac, 0xa5, 0xa2, 0x8f, 0x88, 0x81, 0x86, 0x93, 0x94, 0x9d, 0x9a,
    0x27, 0x20, 0x29, 0x2e, 0x3b, 0x3c, 0x35, 0x32, 0x1f, 0x18, 0x11, 0x16,
    0x03, 0x04, 0x0d, 0x0a, 0x57, 0x50, 0x59, 0x5e, 0x4b, 0x4c, 0x45, 0x42,
    0x6f, 0x68, 0x61, 0x66, 0x73, 0x74, 0x7d, 0x7a, 0x89, 0x8e, 0x87, 0x80,
    0x95, 0x92, 0x9b, 0x9c, 0xb1, 0xb6, 0xbf, 0xb8, 0xad, 0xaa, 0xa3, 0xa4,
    0xf9, 0xfe, 0xf7, 0xf0, 0xe5, 0xe2, 0xeb, 0xec, 0xc1, 0xc6, 0xcf, 0xc8,
    0xdd, 0xda, 0xd3, 0xd4, 0x69, 0x6e, 0x67, 0x60, 0x75, 0x72, 0x7b, 0x7c,
    0x51, 0x56, 0x5f, 0x58, 0x4d, 0x4a, 0x43, 0x44, 0x19, 0x1e, 0x17, 0x10,
    0x05, 0x02, 0x0b, 0x0c, 0x21, 0x26, 0x2f, 0x28, 0x3d, 0x3a, 0x33, 0x34,
    0x4e, 0x49, 0x40, 0x47, 0x52, 0x55, 0x5c, 0x5b, 0x76, 0x71, 0x78, 0x7f,
    0x6a, 0x6d, 0x64, 0x63, 0x3e, 0x39, 0x30, 0x37, 0x22, 0x25, 0x2c, 0x2b,
    0x06, 0x01, 0x08, 0x0f, 0x1a, 0x1d, 0x14, 0x13, 0xae, 0xa9, 0xa0, 0xa7,
    0xb2, 0xb5, 0xbc, 0xbb, 0x96, 0x91, 0x98, 0x9f, 0x8a, 0x8d, 0x84, 0x83,
    0xde, 0xd9, 0xd0, 0xd7, 0xc2, 0xc5, 0xcc, 0xcb, 0xe6, 0xe1, 0xe8, 0xef,
    0xfa, 0xfd, 0xf4, 0xf3
    
};

uint8_t crc8(uint8_t *p, uint8_t len)          //校验函数
{
    uint16_t i;
    uint16_t crc = 0x0;
    
    while (len--) {
        i = (crc ^ *p++) & 0xFF;
        crc = (crc_table[i] ^ (crc << 8)) & 0xFF;
    }
    
    return crc & 0xFF;
}


@end
