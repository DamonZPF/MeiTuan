//
//  MTCategoryController.m
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/16.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTCategoryController.h"
#import "MTCategoryView.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "MTCategoryModel.h"
@interface MTCategoryController ()

@end

@implementation MTCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubviews];
}

-(void)loadSubviews{
    MTCategoryView * categoryView = [MTCategoryView categoryView];
    categoryView.categoryArray = [MTCategoryModel objectArrayWithFilename:@"categories.plist"];
    [self.view addSubview:categoryView];
    self.preferredContentSize = categoryView.size;
    
}

@end
