//
//  MTItemView.h
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTItemView : UIView

@property (weak, nonatomic) IBOutlet UIButton *clickButton;

+(instancetype)item;

-(void)addTarge:(id)target action:(SEL)action;
@end
