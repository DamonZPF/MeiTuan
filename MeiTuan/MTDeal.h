//
//  MTDeal.h
//  MeiTuan
//
//  Created by Duomai on 15/4/15.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDeal : NSObject
@property (copy, nonatomic) NSString *deal_id;
/** 团购标题 */
@property (copy, nonatomic) NSString *title;
/** 团购描述 */
@property (copy, nonatomic) NSString *desc;
/** 如果想完整地保留服务器返回数字的小数位数(没有小数\1位小数\2位小数等),那么就应该用NSNumber */
/** 团购包含商品原价值 */
@property (strong, nonatomic) NSNumber *list_price;
/** 团购价格 */
@property (strong, nonatomic) NSNumber *current_price;
/** 团购当前已购买数 */
@property (assign, nonatomic) int purchase_count;
/** 团购图片链接，最大图片尺寸450×280 */
@property (copy, nonatomic) NSString *image_url;
/** 小尺寸团购图片链接，最大图片尺寸160×100 */
@property (copy, nonatomic) NSString *s_image_url;

@property(copy,nonatomic)NSString * deal_h5_url;

@property(assign,nonatomic)BOOL editing;

@property(assign,nonatomic)BOOL checking;
@end
