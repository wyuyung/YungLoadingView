//
//  ViewController.m
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import "ViewController.h"
#import "YungLoadingView.h"

@interface ViewController ()

@property(nonatomic, strong) YungLoadingView *loadingView;

@property(nonatomic, weak) IBOutlet UIView *testLoadView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.loadingView = [[YungLoadingView alloc] initWithFrame:(CGRect){100, 100, 100, 100}];
//    [self.loadingView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.1]];
//    [self.view addSubview:self.loadingView];
    
    self.loadingView = [YungLoadingView createLoadingView];
}

- (IBAction)clickStart:(id)sender {
    [self.loadingView showLoadingInView:self.testLoadView];
}

- (IBAction)clickStop:(id)sender {
    [self.loadingView stopLoading];
}

- (IBAction)clickAdd:(id)sender {
    CGFloat loadWidth = CGRectGetWidth(self.testLoadView.frame) + 50;
    [self.testLoadView setFrame:(CGRect){self.testLoadView.frame.origin, loadWidth, loadWidth}];
}

- (IBAction)clickDes:(id)sender {
    CGFloat loadWidth = CGRectGetWidth(self.testLoadView.frame) - 50;
    [self.testLoadView setFrame:(CGRect){self.testLoadView.frame.origin, loadWidth, loadWidth}];
}

@end
