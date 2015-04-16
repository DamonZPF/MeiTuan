//
//  MTSortViewController.m
//  MeiTuan
//
//  Created by Duomai on 15/4/13.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTSortViewController.h"
#import "MTMetaTool.h"
#import "MTSortModel.h"
@interface MTSortViewController ()
@property(nonatomic,strong)UIButton * selectedButton;
@end

@implementation MTSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self loadSubView];
    
}


-(void)loadSubView{

    NSArray * sorts = [MTMetaTool sorts];
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = 120;
    CGFloat H = 30;
    CGFloat Margin = 15;
    CGFloat height = 0;
    for (NSInteger index = 0; index < sorts.count; index++) {
        MTSortModel * model = sorts[index];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        [button setTitle:model.label forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected.png"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(X+ Margin, Y+Margin, W, H);
        [self.view addSubview:button];
        Y += H + Margin;
        
        height = CGRectGetMaxY(button.frame);
    }
    
    self.preferredContentSize = CGSizeMake(W + Margin*2, height + Margin);

}

-(void)buttonAction:(UIButton*)btn{
//    btn.selected = YES;
//    self.selectedButton.selected = NO;
//    self.selectedButton = btn;
    
    MTSortModel * sortModel = [MTMetaTool sorts][btn.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MTSrot" object:nil userInfo:@{@"Sort":sortModel}];
}


@end
