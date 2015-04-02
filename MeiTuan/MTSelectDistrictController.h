//
//  MTSelectDistrictController.h
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/16.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTSelectDistrictController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cover; //遮盖蒙版
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)coverAction:(id)sender;

@end
