//
//  ViewController.m
//  CollectionDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData] ;
    [self initCollerction] ;
    
}

- (void)initData{
    self.dataArray = [NSMutableArray array] ;
    for(NSInteger index = 0 ; index < 8 ;index++){
        NSString *imageName = [NSString stringWithFormat:@"%ld",(long)index+1] ;
        NSString *title = [NSString stringWithFormat:@"{0,%ld}",(long)index+1] ;
        NSDictionary *dic = @{@"image": imageName, @"title":title};
        [self.dataArray addObject:dic] ;
    }
}

- (void)initCollerction{
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self ;
    self.collectionView.backgroundColor = [UIColor whiteColor] ;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"] ;
}

#pragma mark - Collection View Data Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell" ;
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath] ;
    NSDictionary *dic = self.dataArray[indexPath.row] ;
    cell.dataDic = dic ;
    
    return cell ;
}
@end
