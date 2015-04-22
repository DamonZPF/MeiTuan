//
//  MTHomeViewController.m
//  MeiTuan_New
//
//  Created by zhoupengfei on 15/3/10.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTHomeViewController.h"

#import "UIBarButtonItem+Extension.h"
#import "MTItemView.h"
#import "MTCategoryController.h"
#import "MTBaseNavController.h"
#import "MTDistrictController.h"
#import "MTSortViewController.h"
#import "MTSortModel.h"


#import "MBProgressHUD+MJ.h"
#import "UIView+AutoLayout.h"
@interface MTHomeViewController ()
@property(nonatomic,strong) UIBarButtonItem * categoryItem;
@property(nonatomic,strong)  UIBarButtonItem * districtItem;
@property(nonatomic,strong) UIBarButtonItem * sortItem;

@property(nonatomic,strong)UIPopoverController * categoryPopVC;
@property(nonatomic,strong)UIPopoverController * areaPopVC;
@property(nonatomic,strong)UIPopoverController * sortPopVC;

@property(nonatomic,weak)UIImageView * nodataView;
@end

@implementation MTHomeViewController

static NSString * const reuseIdentifier = @"Cell";



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNOdataView];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortAction:) name:@"MTSrot" object:nil]; //监听排序按钮

     //加载导航右边按钮
    [self setupRightItem];
    
    //左边按钮
    [self setupLeftItem];
   
}

-(void)setupParams:(NSMutableDictionary *)params{
    // 城市
    params[@"city"] = @"北京";
    // 每页的条数
    params[@"limit"] = @20;
}

-(void)setupNOdataView{
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_latestBrowse_empty"]];
    imageView.hidden = YES;
    [self.view addSubview:imageView];
    [imageView autoCenterInSuperview];
    self.nodataView = imageView;

}




#pragma mark  加载导航右边按钮
-(void)setupRightItem{
    UIBarButtonItem * mapItem = [UIBarButtonItem itemWithTarget:self action:@selector(mapBtnClick) image:@"icon_map" heigImage:@"icon_map_highlighted"];
    mapItem.customView.frame = CGRectMake(0, 0, 60, mapItem.customView.frame.size.height);
    UIBarButtonItem * searchItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchClick) image:@"icon_search" heigImage:@"icon_search_highlighted"];
       searchItem.customView.frame = CGRectMake(0, 0, 60, mapItem.customView.frame.size.height);
    self.navigationItem.rightBarButtonItems = @[mapItem,searchItem];
    
}
#pragma mark  加载导航左边按钮
-(void)setupLeftItem{
    //logo
    UIBarButtonItem * logoItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    logoItem.enabled = NO;
    
    //地区
    MTItemView * categoryItemView = [MTItemView item];
    [categoryItemView  addTarge:self action:@selector(categoryAction)];
    UIBarButtonItem * categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryItemView];
    self.categoryItem = categoryItem;
    
    //地区
    MTItemView * districtItemView = [MTItemView item];
     [districtItemView  addTarge:self action:@selector(areaAction)];
    UIBarButtonItem * districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtItemView];
    self.districtItem = districtItem;
    
    //排序
    MTItemView * sortItemView = [MTItemView item];
    sortItemView.mianLable.text = @"排序";
     [sortItemView  addTarge:self action:@selector(sortAction)];
    UIBarButtonItem * sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortItemView];
    self.navigationItem.leftBarButtonItems = @[logoItem,categoryItem,districtItem,sortItem];
    self.sortItem = sortItem;
}

-(void)categoryAction{
    MTCategoryController * categoryVC = [[MTCategoryController alloc] init];
    UIPopoverController * popvoerController = [[UIPopoverController alloc]initWithContentViewController:categoryVC];
    [popvoerController presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.categoryPopVC = popvoerController;
}

-(void)areaAction{
    MTDistrictController * districtVC = [[MTDistrictController alloc] init];
    UIPopoverController * popvoerController = [[UIPopoverController alloc]initWithContentViewController:districtVC];
    [popvoerController presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    districtVC.popVC = popvoerController;
     self.areaPopVC = popvoerController;
    
}
-(void)sortAction{
    
    MTSortViewController * sortVC = [[MTSortViewController alloc]init];
    UIPopoverController * popvoerController = [[UIPopoverController alloc]initWithContentViewController:sortVC];
    [popvoerController presentPopoverFromBarButtonItem:self.sortItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
     self.sortPopVC = popvoerController;
}


#pragma mark 地图点击
-(void)mapBtnClick{

    
}
#pragma mark 搜索
-(void)searchClick{

}


#pragma mark 监听排序按钮

-(void)sortAction:(NSNotification*)note{
    NSDictionary * tempDic = note.userInfo;
    MTSortModel * model = tempDic[@"Sort"];
    MTItemView * customView = (MTItemView*)self.sortItem.customView;
    customView.secondLabel.text = model.label;
    [self.sortPopVC dismissPopoverAnimated:YES];
}




-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
