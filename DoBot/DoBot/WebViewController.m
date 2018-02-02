//
//  WebViewController.m
//  DoBot
//
//  Created by 羊德元 on 16/8/8.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   UIWebView  *_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _webView.delegate = self;
    //关闭webView的弹回效果
   // [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    
    [self.view addSubview:_webView];
    
    NSString *outputHTML=[[NSString alloc] initWithFormat:@"<body style='margin: 0px; padding: 0px'><img width='%f' height='%f' src='http://192.168.8.1:8083/?action=stream'></body>",SCREEN_WIDTH,SCREEN_HEIGHT];
    [_webView loadHTMLString:outputHTML baseURL:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
