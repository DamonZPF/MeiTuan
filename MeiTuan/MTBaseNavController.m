//
//  MTBaseNavController.m
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/10.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTBaseNavController.h"

@interface MTBaseNavController ()

@end

@implementation MTBaseNavController

+(void)initialize{
    UINavigationBar * navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics: UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
