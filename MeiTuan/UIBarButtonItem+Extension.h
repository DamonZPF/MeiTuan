//
//  UIBarButtonItem+Extension.h
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem*)itemWithTarget:(id)target action:(SEL)action image:(NSString*)image heigImage:(NSString*)heigImage;
@end
