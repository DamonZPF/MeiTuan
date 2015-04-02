//
//  MTCityGroupModel.h
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/17.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCityGroupModel : NSObject
/** 这组的标题 */
@property (nonatomic, copy) NSString *title;
/** 这组的所有城市 */
@property (nonatomic, strong) NSArray *cities;
@end
