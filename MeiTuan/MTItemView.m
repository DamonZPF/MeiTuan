//
//  MTItemView.m
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTItemView.h"

@implementation MTItemView


-(void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;
}

+(instancetype)item{

    return [[[NSBundle mainBundle] loadNibNamed:@"MTItemView" owner:self options:nil] lastObject];
}

-(void)addTarge:(id)target action:(SEL)action{
    [self.clickButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
}

@end
