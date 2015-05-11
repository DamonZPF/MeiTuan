//
//  MTMetaCaChe.h
//  MeiTuan
//
//  Created by Duomai on 15/4/27.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTDeal.h"
@interface MTMetaCaChe : NSObject

//添加收藏
+(void)addCollectDeal:(MTDeal*)dealModel;
//取消收藏
+(void)removeCollectDeal:(MTDeal*)dealModel;

//获取收藏商品
+(NSArray*)collectDeal:(int)page;


 //判断是否已收藏
+(BOOL)isCollected:(MTDeal*)dealModel;


//获取商品总数
+(int)collectedCount;

@end
