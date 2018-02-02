//
//  SettingViewController.m
//  DoBot
//
//  Created by 羊德元 on 16/8/2.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import "SettingViewController.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
   // [self.view addSubview:_tabView];
    
    UIView *coverView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    coverView.alpha=0.2;
    coverView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:coverView];
    
    UIView *setView=[[UIView alloc] initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH-40, SCREEN_HEIGHT-100)];
    setView.backgroundColor=[UIColor whiteColor];
    [setView bringSubviewToFront:coverView];
    [self.view addSubview:setView];
    
    //删除
    UIButton *_delButton=[[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-20)-30, 20, 25, 25)];
    _delButton.backgroundColor=[UIColor grayColor];
    [_delButton setTitle:@"×" forState:UIControlStateNormal];
    _delButton.titleLabel.font=[UIFont systemFontOfSize:35];
    [_delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_delButton addTarget:self action:@selector(dissmissAction) forControlEvents: UIControlEventTouchUpInside ];
    [self.view addSubview:_delButton];
    
    
}
-(void)dissmissAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
#pragma mark  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}
    
#pragma mark  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *mycellId = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:mycellId];
    
    if (myCell==nil) {
        
        myCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycellId];
    }
    
    return myCell;
    
}

@end
