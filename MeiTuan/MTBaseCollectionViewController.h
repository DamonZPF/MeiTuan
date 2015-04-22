//
//  MTBaseCollectionViewController.h
//  MeiTuan
//
//  Created by Duomai on 15/4/21.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTConst.h"
#import "DPAPI.h"
#import "MTDeal.h"
#import "MJExtension.h"
#import "MTDealCell.h"
@interface MTBaseCollectionViewController : UICollectionViewController
@property(nonatomic,strong)NSMutableArray * products;

-(void)setupParams:(NSMutableDictionary*)params;

@end
