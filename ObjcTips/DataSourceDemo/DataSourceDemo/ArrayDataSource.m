//
//  ArrayDataSource.m
//  DataSourceDemo
//
//  Created by 杨晴贺 on 2017/5/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ArrayDataSource.h"

@interface ArrayDataSource ()

@property (nonatomic,strong) NSArray *items ;
@property (nonatomic,copy) NSString *cellIdentifier ;
@property (nonatomic,copy) TableViewCellConfigureBlock configureCellBlock ;

@end

@implementation ArrayDataSource

- (instancetype)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    if (self = [super init]) {
        self.items = anItems ;
        self.cellIdentifier = aCellIdentifier ;
        self.configureCellBlock = aConfigureCellBlock ;
    }
    return self ;
}

- (id)itemAtIndexPath:(NSInteger)index {
    if (self.items.count > index) {
        return self.items[index] ;
    }
    return nil ;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath] ;
    id item = [self itemAtIndexPath:indexPath.row];
    self.configureCellBlock(cell, item) ;
    return cell ;
}

@end
