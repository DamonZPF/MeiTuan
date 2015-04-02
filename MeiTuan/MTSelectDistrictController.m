//
//  MTSelectDistrictController.m
//  MeiTuan
//
//  Created by zhoupengfei on 15/3/16.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTSelectDistrictController.h"
#import "UIBarButtonItem+Extension.h"
#import "MTCityModel.h"
#import "MJExtension.h"
#import "MTCityGroupModel.h"
#import "MTConst.h"
#import "MTCitySearchResultController.h"
#import "UIView+AutoLayout.h"
@interface MTSelectDistrictController ()
@property(nonatomic,strong)NSArray * cityGroups;
@property(nonatomic,strong)MTCitySearchResultController * searchRsultVC;
@end

@implementation MTSelectDistrictController

-(MTCitySearchResultController*)searchRsultVC{
    if (_searchRsultVC == nil) {
        _searchRsultVC = [[MTCitySearchResultController alloc]init];
        
        [self addChildViewController:_searchRsultVC];
        [self.view addSubview:_searchRsultVC.view];
        
        [_searchRsultVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [_searchRsultVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar withOffset:10];
        
    }
    return _searchRsultVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLeftItem];
    
    self.cityGroups = [MTCityGroupModel objectArrayWithFilename:@"cityGroups.plist"];
    self.searchBar.tintColor = RGB(32, 191, 179);
}


#pragma mark UISearch delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    [searchBar setShowsCancelButton:YES animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.5;
    }];

}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.0;
    }];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.0;
    }];
    
    self.searchRsultVC.view.hidden = YES;
    
    self.searchBar.text = nil;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length !=0) {
        self.searchRsultVC.view.hidden = NO;
        self.searchRsultVC.searchText = searchText;
    }else{
    
        self.searchRsultVC.view.hidden = YES;
    }
    
    
}



- (IBAction)coverAction:(id)sender {
    [self.searchBar resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.0;
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MTCityGroupModel * cityGroupModel = self.cityGroups[section];
    return  cityGroupModel.cities.count;
}

#pragma mark UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityGroups.count;
}
#pragma mark UITbableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell ==nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MTCityGroupModel * cityGroupModel = self.cityGroups[indexPath.section];
    cell.textLabel.text = cityGroupModel.cities[indexPath.row];
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    MTCityGroupModel * cityGroupModel = self.cityGroups[section];
    return cityGroupModel.title;
}

-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return [self.cityGroups valueForKeyPath:@"title"];
}

-(void)loadLeftItem{
    UIBarButtonItem * leftItem =[UIBarButtonItem itemWithTarget:self action:@selector(dismiss) image:@"btn_navigation_close" heigImage:@"btn_navigation_close_hl"];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
