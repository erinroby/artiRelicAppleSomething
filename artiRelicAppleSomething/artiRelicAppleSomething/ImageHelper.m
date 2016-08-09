//
//  ImageHelper.m
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/9/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "ImageHelper.h"

@implementation ImageHelper


-(UIImage *)thumbFromImage:(UIImage *)image
{

    CGSize thumbSize = CGSizeMake(50.0, 50.0);
    UIGraphicsBeginImageContext(thumbSize);
    [image drawInRect:CGRectMake(0.0, 0.0, thumbSize.width, thumbSize.height)];
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImage;
}

-(NSData*)dataFromImage:(UIImage *)image
{
    return UIImageJPEGRepresentation(image, 0.7);
}

-(UIImage *)imageFromdata:(NSData *)data
{
    return [UIImage imageWithData:data];
}

@end
