//
//  UIImage+Graphics.m
//  抽取
//
//  Created by 黄伟 on 15/6/17.
//  Copyright (c) 2015年 huangwei. All rights reserved.
//

#import "UIImage+Graphics.h"

@implementation UIImage (Graphics)
+(UIImage *)imageCutInToCircle:(NSString *)imageName{
    //要裁圆的图片
    UIImage *image = [UIImage imageNamed:imageName];
    //图形上下文的尺寸就是图片的尺寸
    UIGraphicsBeginImageContextWithOptions(image.size, 0, 0.0);
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, image.size.width, image.size.height));
    //将当前的图形上下文剪切出来，后面的图形都会限制在这个圆中
    CGContextClip(ctx);
    //从0点开始画图
    [image drawAtPoint:CGPointMake(0, 0)];
    //获得当前图形上下文的图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;
}
+(UIImage *)imageCutInToCircle:(NSString *)imageName withBorderWidth:(CGFloat)borderWidth color:(UIColor *)color{
    //要裁圆的图片
    UIImage *image = [UIImage imageNamed:imageName];
    //边框的宽度，由传进来的参数决定
    CGFloat margin = borderWidth;
    //图形上下文的宽度 ＝ 图片的宽度 ＋ 2倍的边框宽度
    CGFloat width = 2*margin + image.size.width;
    //图形上下文的高度 ＝ 图片的高度 ＋ 2倍的边框宽度
    CGFloat height = 2*margin + image.size.height;
    //图形上下文的尺寸就是包括了边框的尺寸
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), 0, 0.0);
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画大圆，即边框所形成的圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, width, height));
    //设置边框的颜色，由传进来的参数决定
    [color set];
    //渲染这个圆，此时是一个设置的颜色的圆
    CGContextFillPath(ctx);
    //画小圆，即图片所形成的圆
    CGContextAddEllipseInRect(ctx, CGRectMake(margin, margin, image.size.width, image.size.height));
    //裁剪当前的图形上下文，
    CGContextClip(ctx);
    //为了不被边框挡住，所以要从x,y值都为边框宽度的点开始画图片
    [image drawAtPoint:CGPointMake(margin,margin)];
    //获得当前图形上下文的图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;
}
+(UIImage *)image:(NSString *)imageName addLOGO:(NSString *)logoName{
    //水印图片距离背景图片右下角x,y均＝10，根据需要自行更改
    CGFloat margin = 10;
    //背景图片
    UIImage *image = [UIImage imageNamed:imageName];
    //水印图片
    UIImage *logo = [UIImage imageNamed:logoName];
    //以背景图片的尺寸去开启图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, 0, 0.0);
    //背景图片就从0点开始画
    [image drawAtPoint:CGPointMake(0, 0)];
    //计算水印图片绘画时的起点的X值
    CGFloat width = image.size.width - logo.size.width - margin;
    //计算水印图片绘画时的起点的Y值
    CGFloat height = image.size.height - logo.size.height - margin;
    //画水印图片
    [logo drawAtPoint:CGPointMake(width, height)];
    //从当前的图形上下文获得图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;
}
+(UIImage *)image:(NSString *)imageName addText:(NSString *)text attributes:(NSDictionary *)attributes{
    //要处理的图片
    UIImage *image = [UIImage imageNamed:imageName];
    //水印文字
    NSString *string = text;
    //获得的图形上下文以图片的尺寸为准
    UIGraphicsBeginImageContextWithOptions(image.size, 0, 0.0);
    //画图
    [image drawAtPoint:CGPointMake(0, 0)];
    //把字添加到图形上下文，字体的属性需要传值
    [string drawAtPoint:CGPointMake(10, 10) withAttributes:attributes];
    //从当前的图形上下文获得图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;
}
+(UIImage *)captureImageFromLayer:(CALayer *)layer{
    //开启图形上下文，尺寸以要截的图层为准
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, 0, 0.0);
    //获得当前的图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //将要截的图层描绘到图形上下文上
    [layer renderInContext:ctx];
    //从当前的图形上下文得到图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;
}
@end
