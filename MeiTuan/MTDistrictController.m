//
//  MTDistrictController.m
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/16.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTDistrictController.h"
#import "MTCategoryView.h"
#import "UIView+Extension.h"
#import "MTSelectDistrictController.h"
#import "MTBaseNavController.h"
@interface MTDistrictController ()

@end

@implementation MTDistrictController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSubviews];
}

-(void)loadSubviews{
    UIView * topView = [self.view.subviews firstObject];
    MTCategoryView * categoryView = [MTCategoryView categoryView];
    categoryView.y = topView.height;
    [self.view addSubview:categoryView];
    self.preferredContentSize = CGSizeMake(categoryView.width, CGRectGetMaxY(categoryView.frame));
}

- (IBAction)changeCity:(id)sender {
    
    MTSelectDistrictController * selectDistrictVC = [[MTSelectDistrictController alloc]init];
    MTBaseNavController * baseNav = [[MTBaseNavController alloc]initWithRootViewController:selectDistrictVC];
     baseNav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:baseNav animated:YES completion:nil];
    
}
@end
