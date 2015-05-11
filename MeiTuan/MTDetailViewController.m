//
//  MTDetailViewController.m
//  MeiTuan
//
//  Created by Duomai on 15/4/21.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTDetailViewController.h"
#import "MTConst.h"
#import "MTMetaCaChe.h"
@interface MTDetailViewController ()<UIWebViewDelegate>

@end

@implementation MTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MTGlobalBg;
    NSString * id = [self.dealModel.deal_id substringFromIndex:[self.dealModel.deal_id rangeOfString:@"-"].location +1];
    NSString * url = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@",id];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    self.collectBtn.selected = [MTMetaCaChe isCollected:self.dealModel];
}


//仅支持横屏
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //NSLog(@"%@",request.URL.absoluteString);
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    
}

#pragma 收藏到本地
- (IBAction)collecAction:(id)sender {
    UIButton * btn = (UIButton*)sender;
    if (btn.selected) {
        //取消收藏
        [MTMetaCaChe removeCollectDeal:self.dealModel];
        
        
    }else{
        //收藏
        [MTMetaCaChe addCollectDeal:self.dealModel];
    }
    btn.selected = !btn.selected;
    
}
@end
