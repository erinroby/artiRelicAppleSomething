//
//  AudioPlayRecord.m
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/9/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "AudioPlayRecord.h"

@implementation AudioPlayRecord

- (void) setupAudio:(NSString *)fileName{
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *filePath = [NSString stringWithFormat:@"%@.caf", fileName];
    
    NSString *soundFilePath = [docsDir stringByAppendingString: filePath];
    NSLog(@"%@", soundFilePath);
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMax],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt:2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    _audioRecorder = [[AVAudioRecorder alloc]initWithURL:soundFileURL settings:recordSettings error:&error];
    
    if (error) {
        NSLog (@"Error: %@", [error localizedDescription]);
    } else {
        [_audioRecorder prepareToRecord];
    }
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
}

- (void) audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    NSLog(@"Decode error occurred");
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
}

- (void) audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    NSLog(@"Encode error occurred");
}

- (void) recordAudio{
    if (!_audioRecorder.recording) {
        [_audioRecorder record];
    }
}

- (void) playAudio{
    if (!_audioRecorder.recording) {
        
        NSError *error;
        
        _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:_audioRecorder.url error:&error];
        
        _audioPlayer.delegate = self;
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            [_audioPlayer play];
        }
    }
}

- (IBAction)stopAudio:(id)sender {
    
    if (_audioRecorder.recording){
        [_audioRecorder stop];
    } else if (_audioPlayer.playing) {
        [_audioPlayer stop];
    }
}

@end




























