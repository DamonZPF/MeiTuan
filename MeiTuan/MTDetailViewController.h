//
//  MTDetailViewController.h
//  MeiTuan
//
//  Created by Duomai on 15/4/21.
//  Copyright (c) 2015年 zpf. All rights reserved.
//商品详情

#import <UIKit/UIKit.h>
#import "MTDeal.h"
@interface MTDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic)MTDeal * dealModel;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

- (IBAction)collecAction:(id)sender;

@end
