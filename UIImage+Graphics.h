//
//  UIImage+Graphics.h
//  抽取
//
//  Created by 黄伟 on 14/6/17.
//  Copyright (c) 2014年 huangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Graphics)
/**
 *  图片裁圆（无边框）
 *  cut image into circle
 */
+(UIImage *)imageCutInToCircle:(NSString *)imageName;
/**
 *  图片裁圆（有边框）
 *  cut image into circle with border
 */
+(UIImage *)imageCutInToCircle:(NSString *)imageName withBorderWidth:(CGFloat)width color:(UIColor *)color;
/**
 *  图片添加水印图片
 *  add Logo to Image
 */
+(UIImage *)image:(NSString *)imageName addLOGO:(NSString *)logoName;
/**
 *  图片添加水印文字
 *  add text toImage
 */
+(UIImage *)image:(NSString *)imageName addText:(NSString *)text attributes:(NSDictionary *)attributes;
/**
 *  capture 
 *  截屏
 */
+(UIImage *)captureImageFromLayer:(CALayer *)layer;

/**
 * 从中间裁剪一张图片
 */
+(instancetype)resizeImageWithImageName:(NSString *)name;
@end
