//
//  MTCategoryView.h
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/13.
//  Copyright (c) 2015年 zpf. All rights reserved.
//自定义分类

#import <UIKit/UIKit.h>

@interface MTCategoryView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;
@property(strong,nonatomic)NSArray * categoryArray; //主表数据

+(instancetype)categoryView;
@end
