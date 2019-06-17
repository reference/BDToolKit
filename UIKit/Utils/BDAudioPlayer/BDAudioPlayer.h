/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef enum {
    BDSoundType_ShakePeek = 0,//轻微震动
    BDSoundType_ThreeTimes,//震动三次
    BDSoundType_Slip,//滑入
    BDSoundType_GoldFall,//金币掉落
    BDSoundType_Tap,//打字
    BDSoundType_Suprise,//中奖 superise
    BDSoundType_Airdrop,  //空投
    BDSoundType_Error,//错误提示音
    BDSoundType_Ball //MTO 收集元素声音
}BDSoundType;

typedef void(^BDCompletionBlock)(BOOL);

@interface AVAudioPlayerWithCompletionBlock : AVAudioPlayer
@property (nonatomic, copy) BDCompletionBlock completionBlock;
@end

@interface BDAudioPlayer : NSObject <AVAudioPlayerDelegate> {
	NSMutableSet *players;
}

+ (BDAudioPlayer *)shared;

/**
 play sound

 @param type sound type
 */
+ (void)playSoundWithType:(BDSoundType)type;

/*
 The method
 + (AVAudioPlayer *) playFile:(NSString *)name volume:(CGFloat)vol loops:(NSInteger)loops withCompletionBlock:(BDCompletionBlock)completion;
 
 the loops parameter works like this:
 any negative number - sound keeps playing in a loop over and over
 0, 1 - sound is played once
 2, 3, etc - sound is played twice, 3 times, etc-times :)
 */
+ (AVAudioPlayer *) playFile:(NSString *)name volume:(CGFloat)vol loops:(NSInteger)loops withCompletionBlock:(BDCompletionBlock)completion;

/*
 The methods below just call the
 playFile: volume: loops: withCompletionBlock:
 */
+ (AVAudioPlayer *)playFile:(NSString *)name;
+ (AVAudioPlayer *)playFile:(NSString *)name volume:(CGFloat)vol loops:(NSInteger)loops;
+ (AVAudioPlayer *) playFile:(NSString *)name withCompletionBlock:(BDCompletionBlock)completion ;

+ (AVAudioPlayer *) playLoopedFile:(NSString *) name;

+ (void)stopPlayer:(AVAudioPlayer *)player;
+ (void)stopAllPlayers;
+ (void)playFiles:(NSArray *)filesList withCompletionBlock:(BDCompletionBlock) completion;
@end
