//
//  AudioPlayRecord.h
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/9/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayRecord : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (NSString *) setupAudio:(NSString *)fileName;
- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
- (void) audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error;
- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag;
- (void) audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error;
- (void) recordAudio;
- (void) playAudio;
- (void) stopAudio;




@end
