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

#import "BDAudioPlayer.h"

@implementation AVAudioPlayerWithCompletionBlock

@end

@implementation BDAudioPlayer

static BDAudioPlayer *sharedInstance = nil;

+ (void)initialize
{
    if (sharedInstance == nil)
        sharedInstance = [[self alloc] init];
}

+ (BDAudioPlayer *)shared
{
    //Already set by +initialize.
    return sharedInstance;
}

+ (void)playSoundWithType:(BDSoundType)type
{
    switch (type) {
        case BDSoundType_ShakePeek:
            //短震  3D Touch中的peek震动反馈
            AudioServicesPlaySystemSound(1519);
            break;
        case BDSoundType_ThreeTimes:
            //连续三次短震动
            AudioServicesPlaySystemSound(1521);
            break;
        case BDSoundType_Slip:
            [BDAudioPlayer playFile:@"slip.mp3"];
            break;
        case BDSoundType_GoldFall:
            [BDAudioPlayer playFile:@"goldfall.mp3"];
            break;
        case BDSoundType_Tap:
            [BDAudioPlayer playFile:@"tap.mp3"];
            break;
        case BDSoundType_Suprise:
            [BDAudioPlayer playFile:@"superise.mp3"];
            break;
        case BDSoundType_Airdrop:
            [BDAudioPlayer playFile:@"airdrop.mp3"];
            break;
        case BDSoundType_Error:
            [BDAudioPlayer playFile:@"error.mp3"];
            break;
        case BDSoundType_Ball:
            [BDAudioPlayer playFile:@"ball.mp3"];
            break;
        default:
            break;
    }
}

+ (id)allocWithZone:(NSZone*)zone
{
    //Usually already set by +initialize.
    @synchronized(self) {
        if (sharedInstance) {
            //The caller expects to receive a new object, so implicitly retain it
            //to balance out the eventual release message.
            return sharedInstance;
        } else {
            //When not already set, +initialize is our caller.
            //It's creating the shared instance, let this go through.
            return [super allocWithZone:zone];
        }
    }
}

- (id)init
{
    //If sharedInstance is nil, +initialize is our caller, so initialize the instance.
    //If it is not nil, simply return the instance without re-initializing it.
    if (sharedInstance == nil) {
		self = [super init];
		if (self) {
            //Initialize the instance here.
			players = [NSMutableSet setWithCapacity:1];
        }
    }
    return self;
}


- (AVAudioPlayer *) playFile:(NSString *)name volume:(CGFloat)vol loops:(NSInteger)loops withCompletionBlock:(BDCompletionBlock)completion
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
	if(!filePath) {
		return nil;
	}
	
	NSError *error = nil;
	NSURL *fileURL = [NSURL fileURLWithPath:filePath isDirectory:NO];
	AVAudioPlayerWithCompletionBlock *player = [[AVAudioPlayerWithCompletionBlock alloc] initWithContentsOfURL:fileURL error:&error];
	player.volume = vol;
	player.numberOfLoops = loops;
	// Retain and play
	if(player) {
        //
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&error];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        //
		[players addObject:player];
		player.delegate = self;
        player.completionBlock = completion;
		[player play];
		return player;
	}
	return nil;
    
}
- (void) playFiles:(NSArray*) filesList withCompletionBlock:(BDCompletionBlock) completion
{
    __block int idx = 0;
    __block void(^playBlock)(void);
    playBlock = ^() {
        [[AVAudioSession sharedInstance] setActive:NO withOptions:kAudioSessionSetActiveFlag_NotifyOthersOnDeactivation error:nil];
        if (idx >= filesList.count) {
            if (completion) {
                completion ( YES );
            }
            playBlock = nil;
            return;
        }
        [self playFile:filesList[idx] withCompletionBlock:^(BOOL completed) {
            playBlock ();
        }];
        idx ++;
    };
    playBlock ();
}

- (AVAudioPlayer *)playFile:(NSString *)name {
    
    return [self playFile:name volume:1.0f loops:0 withCompletionBlock:nil];
}
- (AVAudioPlayer *) playLoopedFile:(NSString *) name {
    return [self playFile:name volume:1.0f loops:-1];
}
- (AVAudioPlayer *) playFile:(NSString *)name withCompletionBlock:(BDCompletionBlock)completion
{
    return [self playFile:name volume:1.0f loops:0 withCompletionBlock:completion];
}

- (AVAudioPlayer *)playFile:(NSString *)name volume:(CGFloat)vol loops:(NSInteger)loops {
    
	return [self playFile:name volume:vol loops:loops withCompletionBlock:nil];
}


- (void)stopPlayer:(AVAudioPlayer *)player {
	if([players containsObject:player]) {
		player.delegate = nil;
		[players removeObject:player];
		[player stop];
	}
}

- (void)stopAllPlayers {
    NSSet *pls = [NSSet setWithSet:players];
    for (AVAudioPlayer *p in pls) {
        [self stopPlayer:p];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayerWithCompletionBlock *)player successfully:(BOOL)completed {
    
	if (player.completionBlock) {
        player.completionBlock ( completed );
    }
	player.delegate = nil;
	[players removeObject:player];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
	//TRC_DBG(@"audioPlayerDecodeErrorDidOccur %@", error);
	player.delegate = nil;
	[players removeObject:player];
}

+ (AVAudioPlayer *)playFile:(NSString *)name {
	return [[BDAudioPlayer shared] playFile:name];
}

+ (AVAudioPlayer *)playFile:(NSString *)name volume:(CGFloat)vol loops:(NSInteger)loops {
	return [[BDAudioPlayer shared] playFile:name volume:vol loops:loops];
}
+ (AVAudioPlayer *) playFile:(NSString *)name withCompletionBlock:(BDCompletionBlock)completion
{
    return [[BDAudioPlayer shared] playFile:name withCompletionBlock:completion];
}
+ (AVAudioPlayer *) playFile:(NSString *)name volume:(CGFloat)vol loops:(NSInteger)loops withCompletionBlock:(BDCompletionBlock)completion
{
    return [[BDAudioPlayer shared] playFile:name volume:vol loops:loops withCompletionBlock:completion];
}
+ (AVAudioPlayer *) playLoopedFile:(NSString *) name
{
    return [[BDAudioPlayer shared] playLoopedFile:name];
}
+ (void)stopPlayer:(AVAudioPlayer *)player {
	return [[BDAudioPlayer shared] stopPlayer:player];
}
+ (void)stopAllPlayers {
    return [[BDAudioPlayer shared] stopAllPlayers];
}
+ (void) playFiles:(NSArray *)filesList withCompletionBlock:(BDCompletionBlock)completion
{
    [[BDAudioPlayer shared] playFiles:filesList withCompletionBlock:completion];
}
@end
