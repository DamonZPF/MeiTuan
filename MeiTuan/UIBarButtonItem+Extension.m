//
//  UIBarButtonItem+Extension.m
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem*)itemWithTarget:(id)target action:(SEL)action image:(NSString*)image heigImage:(NSString*)heigImage{
    UIButton * button  = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:heigImage] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    return barItem;
}
@end
