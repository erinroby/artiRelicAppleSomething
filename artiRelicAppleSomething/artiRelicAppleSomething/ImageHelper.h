//
//  ImageHelper.h
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/9/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface ImageHelper : NSObject

+ (instancetype)shared;
- (UIImage *)thumbFromImage:(UIImage *)image;
- (NSData*)dataFromImage:(UIImage *)image;
- (UIImage *)imageFromdata:(NSData *)data;

@end
