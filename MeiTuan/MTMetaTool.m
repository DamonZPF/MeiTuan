//
//  MTMetaTool.m
//  MeiTuan
//
//  Created by Duomai on 15/4/13.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTMetaTool.h"
#import "MTSortModel.h"
#import "MJExtension.h"
@implementation MTMetaTool
+(NSArray*)sorts{
 
    NSArray * tempArray =  [MTSortModel objectArrayWithFilename:@"sorts.plist"];
    return tempArray;

}
@end
