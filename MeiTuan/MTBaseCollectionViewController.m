//
//  MTBaseCollectionViewController.m
//  MeiTuan
//
//  Created by Duomai on 15/4/21.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTBaseCollectionViewController.h"
#import "MTDetailViewController.h"
@interface MTBaseCollectionViewController ()<DPRequestDelegate>

@end

@implementation MTBaseCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(void)setupParams:(NSDictionary*)params{}

-(NSMutableArray*)products{
    
    if (_products == nil) {
        _products = [NSMutableArray array];
    }
    return _products;
}

-(instancetype)init{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(305, 305);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 10, 20);
    return  [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = MTGlobalBg;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
       [self loadData]; //加载网络数据
}


#pragma mark 加载网络数据
-(void)loadData{
    DPAPI * api = [[DPAPI alloc]init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self setupParams:params];
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
    [self.products removeAllObjects];
    [self.products addObjectsFromArray:tempArray];
    [self.collectionView reloadData];
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    [self viewWillTransitionToSize:CGSizeMake(collectionView.frame.size.width, 0) withTransitionCoordinator:nil];
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

#pragma mark 监听屏幕的旋转
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout*) self.collectionViewLayout;
    int col = size.width == 1024?3:2;
    CGFloat inset =  (size.width - col * flowLayout.itemSize.width) / (col + 1);
    flowLayout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    
}


#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MTDetailViewController * detilVC = [[MTDetailViewController alloc]init];
      detilVC.dealModel = self.products[indexPath.item];
    [self presentViewController:detilVC animated:YES completion:nil];
    
}


@end
