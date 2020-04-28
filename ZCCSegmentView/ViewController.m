//
//  ViewController.m
//  ZCCSegmentView
//
//  Created by Laibu tech_2 on 2020/4/28.
//  Copyright © 2020 Laibu tech_2. All rights reserved.
//

#import "ViewController.h"
#import "ZCCSegmentView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self);
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self loadSubvies];
}

- (void)loadSubvies {
    ZCCSegmentView *segemntView = [[ZCCSegmentView alloc] initWithSegmentsArray:@[@"菜单栏1", @"测试测试测试", @"菜单栏333"] seletedIcon:nil margin:kWidth(10) normalFontSize:kWidth(30) selectFontSize:kWidth(34)];
    CGSize segmentSize = [segemntView getSegmentViewSize];
    segemntView.frame = CGRectMake(0, 100, segmentSize.width, segmentSize.height);
    [self.view addSubview:segemntView];
    
    
    
    
}


@end
