//
//  MTCategorySubCell.m
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/16.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTCategorySubCell.h"

@implementation MTCategorySubCell

+(instancetype)cellWithTableView:(UITableView*)tableView{
    static NSString * cellIdentifier = @"subCellId";
    MTCategorySubCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MTCategorySubCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView * backgroundView = [[UIImageView alloc]init];
        backgroundView.image = [UIImage imageNamed:@"bg_dropdown_rightpart"];
        self.backgroundView = backgroundView;
        
        
        UIImageView * selectedBackgroundView = [[UIImageView alloc]init];
        selectedBackgroundView.image = [UIImage imageNamed:@"bg_dropdown_right_selected"];
        self.backgroundView = backgroundView;
        self.selectedBackgroundView = selectedBackgroundView;
    }
    return self;
}


@end
