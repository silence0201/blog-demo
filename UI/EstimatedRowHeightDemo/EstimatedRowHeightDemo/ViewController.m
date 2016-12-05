//
//  ViewController.m
//  EstimatedRowHeightDemo
//
//  Created by 杨晴贺 on 05/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData] ;
    [self setupUI] ;
    
    
}

- (void)initData{
    self.dataSource = [NSMutableArray array] ;
    NSString * str1 =@"A table view displays a list of items in a single column. UITableView is a subclass of UIScrollView, which allows users to scroll through the table, although UITableView allows vertical scrolling only. The cells comprising the individual items of the table are UITableViewCell objects; UITableView uses these objects to draw the visible rows of the table. Cells have content—titles and images—and can have, near the right edge, accessory views. Standard accessory views are disclosure indicators or detail disclosure buttons; the former leads to the next level in a data hierarchy and the latter leads to a detailed view of a selected item. Accessory views can also be framework controls, such as switches and sliders, or can be custom views. Table views can enter an editing mode where users can insert, delete, and reorder rows of the table.";
    NSString * str2 =@"A table view is made up of zero or more sections, each with its own rows. Sections are identified by their index number within the table view, and rows are identified by their index number within a section. Any section can optionally be preceded by a section header, and optionally be followed by a section footer.";
    NSString * str3 =@"Table views can have one of two styles, UITableViewStylePlain and UITableViewStyleGrouped. When you create a UITableView instance you must specify a table style, and this style cannot be changed. In the plain style, section headers and footers float above the content if the part of a complete section is visible. A table view can have an index that appears as a bar on the right hand side of the table (for example, 1A1 through Z). You can touch a particular label to jump to the target section. The grouped style of table view provides a default background color and a default background view for all cells. The background view provides a visual grouping for all cells in a particular section. For example, one group could be a person's name and title, another group for phone numbers that the person uses, and another group for email accounts and so on. See the Settings application for examples of grouped tables. Table views in the grouped style cannot have an index.";
    
    for (int i = 0; i < 24; i++) {
        if (i%3 == 0) {
            [self.dataSource addObject:str1];
        }else if (i%3 == 1){
            [self.dataSource addObject:str2];
        }else{
            [self.dataSource addObject:str3];
        }
    }
}

- (void)setupUI{
    //创建一个表格视图
    UITableView * tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorInset = UIEdgeInsetsZero ;
    
    [tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"] ;
    
    //关键就是这两句代码，cell拉好约束写上这两句代码，然后它就会根据自己的内容计算高度了
    tableView.estimatedRowHeight = 44.0f;//推测高度，必须有，可以随便写多少
    tableView.rowHeight =UITableViewAutomaticDimension;//iOS8之后默认就是这个值，可以省略
    [self.view addSubview:tableView] ;
}

#pragma mark --- TableView Delegate 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    cell.label1.text = [NSString stringWithFormat:@"标题%ld",indexPath.row] ;
    cell.label2.text = self.dataSource[indexPath.row] ;
    return cell ;
}



@end
