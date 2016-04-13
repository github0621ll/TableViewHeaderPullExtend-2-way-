//
//  ViewController.m
//  TableViewSelfHeaderDemo
//
//  Created by Fll on 16/4/13.
//  Copyright © 2016年 fll. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGRect initialFrame;
    CGFloat defaultViewHeight;
    UIImageView *imagee;
}
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createData];
    [self customUI];
}
- (void)createData
{
    _dataArr=[[NSMutableArray alloc] init];
    
    for (int i=0; i<20; i++) {
        NSString *nameStr=[NSString stringWithFormat:@"第%d个人",i];
        [_dataArr addObject:nameStr];
    }
}
-(void)customUI
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    _tableView.showsVerticalScrollIndicator=NO;//隐藏滚动条
    
    imagee = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width / 2) - 40 , 25, 150, 150)];
    imagee.backgroundColor = [UIColor redColor];
    imagee.image =[UIImage imageNamed:@"1.png"];
    _tableView.tableHeaderView = imagee;
    
    initialFrame       = imagee.frame;
    defaultViewHeight  = initialFrame.size.height;
    UIView *contentView = [[UIView alloc] initWithFrame:imagee.bounds];
    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    _tableView.tableHeaderView = emptyTableHeaderView;
    [_tableView addSubview:imagee];
    [_tableView addSubview:contentView];
    
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 85, 60, 60)];
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:btn];
//    [_tableView insertSubview:btn atIndex:[[_tableView subviews] count]];
    btn.layer.cornerRadius=30;
    btn.layer.masksToBounds=YES;
}
-(void)btnClick
{
    NSLog(@"hahhahahahhaha");
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
        CGRect f     = imagee.frame;
        f.size.width = _tableView.frame.size.width;
        imagee.frame  = f;
    
        if(scrollView.contentOffset.y < 0)
        {
            CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
    
            initialFrame.origin.y = - offsetY * 1;
            initialFrame.origin.x = - offsetY / 2;
    
            initialFrame.size.width  = _tableView.frame.size.width + offsetY;
            initialFrame.size.height = defaultViewHeight + offsetY;
    
            imagee.frame = initialFrame;
        }
    
}
- (void)viewDidLayoutSubviews
{
    initialFrame.size.width = _tableView.frame.size.width;
    imagee.frame = initialFrame;
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
