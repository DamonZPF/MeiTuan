//
//  MTThroughLabel.m
//  MeiTuan
//
//  Created by Duomai on 15/4/16.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTThroughLabel.h"

@implementation MTThroughLabel


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIRectFill(CGRectMake(0, rect.size.height * 0.5, rect.size.width, 1));
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
// 画线
// 设置起点
//    CGContextMoveToPoint(ctx, 0, rect.size.height * 0.5);
//    // 连线到另一个点
//    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height * 0.5);
//    // 渲染
//    CGContextStrokePath(ctx);

}


@end
