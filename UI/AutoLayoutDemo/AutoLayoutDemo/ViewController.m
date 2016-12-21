//
//  ViewController.m
//  AutoLayoutDemo
//
//  Created by 杨晴贺 on 19/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "DemoCell.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *dataArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    [self initData] ;
}

- (void)initData{
    NSString *demo0Description = @"自动布局动画，修改一个view的布局约束，其他view也会自动重新排布";
    NSString *demo1Description = @"1.设置view1高度根据子view而自适应(在view1中加入两个子view(testLabel和testView)，然后设置view1高度根据子view内容自适应)\n2.高度自适应lable\n3.宽度自适应label";
    NSString *demo2Description = @"1.自定义button内部label和imageView的位置\n2.设置间距固定自动调整宽度的一组子view\n3.设置宽度固定自动调整间距的一组子view";
    NSString *demo3Description = @"简单tableview展示";
    NSString *demo4Description = @"1.行间距为8的attributedString的label";
    NSString *demo5Description = @"1.利用普通view的内容自适应功能添加tableheaderview\n2.利用自动布局功能实现cell内部图文排布，图片可根据原始尺寸按比例缩放后展示\n3.利用“普通版tableview的cell高度自适应”完成tableview的排布";
    NSString *demo6Description = @"展示scrollview的内容自适应和普通view的动态圆角处理";
    NSString *demo7Description = @"利用“普通版tableview的《多cell》高度自适应”2步设置完成tableview的排布";
    NSString *demo8Description = @"利用“升级版tableview的《多cell》高度自适应”1步完成tableview的排布。\n注意：升级版方法适用于cell的model有多个的情况下,性能比普通版稍微差一些,不建议在数据量大的tableview中使用（cell数量尽量少于100个）,如果有大量的cell或者cell界面复杂渲染耗费性能较大则推荐使用普通方法简化版“cellHeightForIndexPath:model:keyPath:cellClass:contentViewWidth:”方法同样是一步设置即可完成";
    NSString *demo9Description = @"利用SDAutoLayout仿制微信朋友圈。高仿微信计划：\n1.高仿朋友圈 \n2.完善细节 \n3.高仿完整微信app \nPS：代码会持续在我的github更新";
    NSString *demo10Description = @"一个SDAutoLayout使用者“李西亚”同学贡献的仿网易新闻界面";
    NSString *demo11Description = @"仿微信的聊天界面：\n1.纯文本消息（带可点击链接，表情）\n2.图片消息";
    NSString *demo12Description = @"scroll任意布局内容自适应";
    NSString *demo13Description = @"scroll任意布局内容自适应自动布局";
    NSString *demo14Description = @"xib的cell高度自适应";
    self.dataArray = @[demo0Description,demo1Description,demo2Description,demo3Description,demo4Description,demo5Description,demo6Description,demo7Description,demo8Description,demo9Description,demo10Description,demo11Description,demo12Description,demo13Description,demo14Description] ;
}

#pragma mark --- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"DemoCell" ;
    DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID] ;
    if (!cell) {
        cell = [[DemoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID] ;
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"Demo -- %ld", (long)indexPath.row];
    cell.contentLabel.text = _dataArray[indexPath.row];
    return cell ;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 一行代码（一步设置）搞定tableview的cell高度自适应
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *demoClassString = [NSString stringWithFormat:@"DemoVC%ld", (long)indexPath.row];
    UIViewController *vc = [NSClassFromString(demoClassString) new];
    vc.title = demoClassString;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
