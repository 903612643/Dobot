//
//  SystemSounds.h
//  DoBot
//
//  Created by 羊德元 on 16/7/20.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SystemSounds : NSObject
{
    SystemSoundID thesound;//系统声音的id 取值范围为：1000-2000
}

- (id)initSystemShake;//系统 震动
- (void)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType;//初始化系统声音
- (void)play;//播放

uint8_t crc8(uint8_t *p, uint8_t len);

@end
