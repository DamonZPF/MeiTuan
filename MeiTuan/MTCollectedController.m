//
//  MTCollectedController.m
//  MeiTuan
//
//  Created by Duomai on 15/4/28.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTCollectedController.h"
#import "MTMetaCaChe.h"
#import "MTDealCell.h"
#import "MJRefresh.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+AutoLayout.h"
NSString *const MTDone = @"完成";
NSString *const MTEdit = @"编辑";
#define MTString(str) [NSString stringWithFormat:@"  %@  ", str]
@interface MTCollectedController ()
@property(nonatomic,strong)NSMutableArray * datas;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,weak)UIImageView * nodataImageView;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *selectAllItem;
@property (nonatomic, strong) UIBarButtonItem *unselectAllItem;
@property (nonatomic, strong) UIBarButtonItem *removeItem;
@end



@implementation MTCollectedController
static NSString *  const identifier = @"Cell";
-(NSMutableArray*)datas{
    
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    
    return _datas;
}

- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        self.backItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_back" heigImage:@"icon_back_highlighted"];
    }
    return _backItem;
}

- (UIBarButtonItem *)selectAllItem
{
    if (!_selectAllItem) {
        self.selectAllItem = [[UIBarButtonItem alloc] initWithTitle:MTString(@"全选") style:UIBarButtonItemStyleDone target:self action:@selector(selectAll)];
    }
    return _selectAllItem;
}

- (UIBarButtonItem *)unselectAllItem
{
    if (!_unselectAllItem) {
        self.unselectAllItem = [[UIBarButtonItem alloc] initWithTitle:MTString(@"全不选") style:UIBarButtonItemStyleDone target:self action:@selector(unselectAll)];
    }
    return _unselectAllItem;
}

- (UIBarButtonItem *)removeItem
{
    if (!_removeItem) {
        self.removeItem = [[UIBarButtonItem alloc] initWithTitle:MTString(@"删除") style:UIBarButtonItemStyleDone target:self action:@selector(remove)];
        self.removeItem.enabled = NO;
    }
    return _removeItem;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)edit:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:MTEdit]) {
        item.title = MTDone;
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.selectAllItem, self.unselectAllItem, self.removeItem];
        for (MTDeal * deal  in self.datas) {
            deal.editing = YES;
        }

    } else {
        item.title = MTEdit;
        self.navigationItem.leftBarButtonItems = @[self.backItem];
        for (MTDeal * deal  in self.datas) {
            deal.editing = NO;
        }
    }
    
    // 刷新表格
    [self.collectionView reloadData];
}

- (void)selectAll
{

    
    self.removeItem.enabled = YES;
}

- (void)unselectAll
{

    
    self.removeItem.enabled = NO;
}

- (void)remove
{
    
    self.removeItem.enabled = NO;
}

-(UIImageView*)nodataImageView{
    if (_nodataImageView == nil) {
        UIImageView * img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"icon_collects_empty"];
         [self.view addSubview:img];
        [img autoCenterInSuperview];
       
        self.nodataImageView = img;
    }
    return _nodataImageView;
}

-(instancetype)init{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(305, 305);
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 10, 20);
    return [self initWithCollectionViewLayout:flowLayout];
}

-(void)setupCollection{
    
    self.collectionView.backgroundColor = MTGlobalBg;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    self.collectionView.alwaysBounceVertical = YES;
    __weak typeof(self) weakSlf = self;
    [self.collectionView addFooterWithCallback:^{
        [weakSlf loadMoreDeal];
    }];
}

-(void)loadMoreDeal{
    self.currentPage++;
    [self.datas addObjectsFromArray:[MTMetaCaChe collectDeal:self.currentPage]];
    [self.collectionView reloadData];
    [self.collectionView footerEndRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollection];
    [self loadMoreDeal];
    
    // 设置导航栏内容
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:MTEdit style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
  
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    [self viewWillTransitionToSize:CGSizeMake(collectionView.frame.size.width, 0) withTransitionCoordinator:nil];
    if (self.datas.count == [MTMetaCaChe collectedCount]) {
        self.collectionView.footerHidden = YES;
    }
    self.nodataImageView.hidden = (self.datas.count !=0);
      return self.datas.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MTDealCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.deal = self.datas[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
}


-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
     //定义列数
    int col = (size.width == 1024) ? 3 : 2;
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    CGFloat inset = (size.width - flowLayout.itemSize.width * col) / (col+1);
    flowLayout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    flowLayout.minimumLineSpacing = 50;
}




@end
