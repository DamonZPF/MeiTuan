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
@interface MTHomeViewController ()
@property(nonatomic,strong) UIBarButtonItem * categoryItem;
@property(nonatomic,strong)  UIBarButtonItem * districtItem;
@end

@implementation MTHomeViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    UICollectionViewLayout * layout = [[UICollectionViewLayout alloc]init];
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.collectionView.backgroundColor = MTGlobalBg;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
     //加载导航右边按钮
    [self setupRightItem];
    
    //左边按钮
    [self setupLeftItem];
   
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
     [sortItemView  addTarge:self action:@selector(sortAction)];
    UIBarButtonItem * sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortItemView];
    self.navigationItem.leftBarButtonItems = @[logoItem,categoryItem,districtItem,sortItem];
}

-(void)categoryAction{
    MTCategoryController * categoryVC = [[MTCategoryController alloc] init];
    UIPopoverController * popvoerController = [[UIPopoverController alloc]initWithContentViewController:categoryVC];
    [popvoerController presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)areaAction{
    MTDistrictController * districtVC = [[MTDistrictController alloc] init];
    UIPopoverController * popvoerController = [[UIPopoverController alloc]initWithContentViewController:districtVC];
    [popvoerController presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
-(void)sortAction{
        MTLog(@"排序");
}


#pragma mark 地图点击
-(void)mapBtnClick{

    
}
#pragma mark 搜索
-(void)searchClick{

}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
