//
//  MTCategoryView.m
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/13.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTCategoryView.h"
#import "MTCategoryModel.h"
#import "MTCategoryMainCell.h"
#import "MTCategorySubCell.h"
@interface MTCategoryView()
@property(strong,nonatomic)MTCategoryModel * selectedCategory; //选中的分类数据
@end
@implementation MTCategoryView

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

+(instancetype)categoryView{
    return   [[[NSBundle mainBundle]loadNibNamed:@"MTCategoryView" owner:nil options:nil] lastObject];
}


#pragma mark DataScource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.mainTableView) {
        return self.categoryArray.count;
    }else
    {
        return   self.selectedCategory.subcategories.count;
        
    }

}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
// 
//}

#pragma mark UITbableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTableView) {
        MTCategoryMainCell * cell = [MTCategoryMainCell cellWithTableView:tableView];
        MTCategoryModel * categoryModel = [self.categoryArray objectAtIndex:indexPath.row];
        cell.textLabel.text = categoryModel.name;
        cell.imageView.image = [UIImage imageNamed:categoryModel.small_icon];
        if (categoryModel.subcategories.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
              cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;

    }else{
        MTCategorySubCell * cell = [MTCategorySubCell cellWithTableView:tableView];
        cell.textLabel.text = self.selectedCategory.subcategories[indexPath.row];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTableView) {
        self.selectedCategory = self.categoryArray[indexPath.row];
        [self.subTableView reloadData];
    }
}


@end
