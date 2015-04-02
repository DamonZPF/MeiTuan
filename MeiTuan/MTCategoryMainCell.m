//
//  MTCategoryMainCell.m
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/16.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTCategoryMainCell.h"

@implementation MTCategoryMainCell
+(instancetype)cellWithTableView:(UITableView*)tableView{
    static NSString * cellIdentifier = @"mainCellId";
    MTCategoryMainCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MTCategoryMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView * backgroundView = [[UIImageView alloc]init];
        backgroundView.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        self.backgroundView = backgroundView;
        
        
        UIImageView * selectedBackgroundView = [[UIImageView alloc]init];
        selectedBackgroundView.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        self.backgroundView = backgroundView;
        self.selectedBackgroundView = selectedBackgroundView;
    }
    return self;
}

@end
