//
//  MTMetaCaChe.m
//  MeiTuan
//
//  Created by Duomai on 15/4/27.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "MTMetaCaChe.h"
#import "FMDB.h"
@implementation MTMetaCaChe
static FMDatabaseQueue * _queue;
+(void)initialize{

    NSString * file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * filePath = [file stringByAppendingPathComponent:@"meta.sqlite"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_collect(id integer primary key autoincrement,deal blob NOT NULL,deal_id text NOT NULL);"]; //收藏表
        [db executeUpdate:@"create table if not exists t_recent(id integer primary key autoincrement,deal blob NOT NULL,deal_id text NOT NULL);"]; //最近浏览表
    }];
}

//添加收藏
+(void)addCollectDeal:(MTDeal*)dealModel{
     NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dealModel];
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdateWithFormat:@"insert into t_collect(deal,deal_id) values(%@,%@);",data,dealModel.deal_id];
    }];
    
}

//获取收藏商品
+(NSArray*)collectDeal:(int)page{
    __block NSMutableArray * dataArray = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        int size = 20;
        int pos = (page -1)*size;
        FMResultSet * set = [db executeQueryWithFormat:@"select * from t_collect order by id desc limit %d,%d;",pos,size];
        while (set.next) {
            MTDeal * deal = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"deal"]];
            [dataArray addObject:deal];
          
        }
    }];
  
    return dataArray;
}

//取消收藏
+(void)removeCollectDeal:(MTDeal*)dealModel{
   
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdateWithFormat:@"delete from t_collect where deal_id = %@",dealModel.deal_id];
    }];
}


//是否已收藏
+(BOOL)isCollected:(MTDeal*)dealModel{
    __block BOOL isCollected = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQueryWithFormat:@"select count(*) as deal_count from t_collect where deal_id =  %@;",dealModel.deal_id];
        [set next];
        if ( [set intForColumn:@"deal_count"] == 1) {
            isCollected = YES;
        }
        [set close];
    }];
    
    return isCollected;
}
//商品总数
+(int)collectedCount{
    
    __block int count = 0;
    [_queue inDatabase:^(FMDatabase *db) {
      FMResultSet * set =   [db executeQuery:@"select count(*) as deal_count from t_collect"];
        while ([set next]) {
            count = [set intForColumn:@"deal_count"];
        }
        
    }];
    return count;
}

@end
