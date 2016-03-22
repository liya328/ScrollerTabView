//
//  ViewController.m
//  ScrollerTabViewDemo
//
//  Created by yangli on 22/3/16.
//  Copyright © 2016 liya. All rights reserved.
//

#import "ViewController.h"
#import "ScrollerTabView.h"

@interface ViewController () <ScrollTabViewDelegate>

@property (strong, nonatomic) ScrollerTabView *titleScrollTabView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.titleScrollTabView = [[ScrollerTabView alloc] initWithTitleArray:@[@"title0",@"title1",@"title2",@"title3",@"title4",@"title5",@"title6",@"title7",@"title8"] frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    self.titleScrollTabView.tabDelegate = self;
    self.titleScrollTabView.tabIndex = 3;
    [self.view addSubview:self.titleScrollTabView];
    
    //    self.titleScrollTabView.tabWidth = 90;    //可以设置tab的宽度
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScrollTabViewDelegate

- (void)tabClicked:(ScrollerTabView *)scrollTabView index:(NSInteger)index {
    NSLog(@"ScrollTabViewDelegate,index = %ld",(long)index);
}

@end
