//
//  ViewController.m
//  TableViewHeaderDemo
//
//  Created by Fll on 16/4/12.
//  Copyright © 2016年 fll. All rights reserved.
//

#import "ViewController.h"
#import "HFStretchableTableHeaderView.h"

#define StretchHeaderHeight 200
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *imagee;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}
@property (nonatomic,strong)HFStretchableTableHeaderView *stretchHeaderView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createData];
    [self customUI];
}
-(void)customUI
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;//隐藏滚动条
    [self.view addSubview:_tableView];

    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, StretchHeaderHeight)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpeg"]];
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:_tableView withView:bgImageView subViews:contentView];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-20, 85, 60, 60)];
    btn.backgroundColor=[UIColor redColor];
    [_tableView addSubview:btn];
    [_tableView insertSubview:btn atIndex:[[_tableView subviews] count]];
    btn.layer.cornerRadius=30;
    btn.layer.masksToBounds=YES;
}

- (void)createData
{
    _dataArr=[[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        NSString *nameStr=[NSString stringWithFormat:@"第%d个人",i];
        [_dataArr addObject:nameStr];
    }
}
#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.text=[_dataArr objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - stretchableTable delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
}
- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消cell选中状态
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
