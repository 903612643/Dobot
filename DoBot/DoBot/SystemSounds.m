//
//  SystemSounds.m
//  DoBot
//
//  Created by 羊德元 on 16/7/20.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import "SystemSounds.h"

@implementation SystemSounds

- (id)initSystemShake
{
    self = [super init];
    if (self) {
        thesound = kSystemSoundID_Vibrate;//震动
    }
    return self;
}

- (void)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType
{
    //self = [super init];
    if (self) {
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];
        //[[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ]pathForResource:soundName ofType:soundType];//得到苹果框架资源UIKit.framework ，从中取出所要播放的系统声音的路径
        //[[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];  获取自定义的声音
        if (path) {
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&thesound);
            
            if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
               // thesound = nil;
            }
        }
    }
   // return self;
}

- (void)play
{
    AudioServicesPlaySystemSound(thesound);
}



@end
