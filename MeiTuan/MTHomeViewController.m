//
//  MTHomeViewController.m
//  MeiTuan_New
//
//  Created by zhoupengfei on 15/3/10.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTConst.h"
#import "UIBarButtonItem+Extension.h"
#import "MTItemView.h"
#import "MTCategoryController.h"
#import "MTBaseNavController.h"
#import "MTDistrictController.h"
#import "MTSortViewController.h"
#import "MTSortModel.h"
#import "DPAPI.h"
#import "MTDeal.h"
#import "MJExtension.h"
#import "MTDealCell.h"
@interface MTHomeViewController ()<DPRequestDelegate>
@property(nonatomic,strong) UIBarButtonItem * categoryItem;
@property(nonatomic,strong)  UIBarButtonItem * districtItem;
@property(nonatomic,strong) UIBarButtonItem * sortItem;

@property(nonatomic,strong)UIPopoverController * categoryPopVC;
@property(nonatomic,strong)UIPopoverController * areaPopVC;
@property(nonatomic,strong)UIPopoverController * sortPopVC;
@property(nonatomic,strong)NSMutableArray * products;
@end

@implementation MTHomeViewController

static NSString * const reuseIdentifier = @"Cell";

-(NSMutableArray*)products{

    if (_products == nil) {
        _products = [NSMutableArray array];
    }
    return _products;
}

-(instancetype)init{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(300, 300);
    return  [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
     self.collectionView.backgroundColor = MTGlobalBg;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortAction:) name:@"MTSrot" object:nil]; //监听排序按钮
     //加载导航右边按钮
    [self setupRightItem];
    
    //左边按钮
    [self setupLeftItem];
    
    [self loadData]; //加载网络数据
   
}

#pragma mark 加载网络数据

-(void)loadData{

    DPAPI * api = [[DPAPI alloc]init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    // 城市
    params[@"city"] = @"北京";
    // 每页的条数
    params[@"limit"] = @5;
//    // 分类(类别)
//    if (self.selectedCategoryName) {
//        params[@"category"] = @"";
//    }
//    // 区域
//    if (self.selectedRegionName) {
//        params[@"region"] = @"";
//    }
//    // 排序
//    if (self.selectedSort) {
//        params[@"sort"] = @(1);
//    }
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}


- (void)request:(DPRequest *)request didReceiveResponse:(NSURLResponse *)response{
}
- (void)request:(DPRequest *)request didReceiveRawData:(NSData *)data{
}
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{

}
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{

    NSArray * tempArray = [[MTDeal objectArrayWithKeyValuesArray:result[@"deals"]] mutableCopy];
    [self.products addObjectsFromArray:tempArray];
    [self.collectionView reloadData];
    
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


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTDealCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.deal = self.products[indexPath.item];
    return cell;
}

#pragma mark <UICollectionViewDelegate>



-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
