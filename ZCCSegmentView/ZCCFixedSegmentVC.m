//
//  ZCCFixedSegmentVC.m
//  ZCCSegmentView
//
//  Created by ZCc on 2020/5/6.
//  Copyright © 2020 Laibu tech_2. All rights reserved.
//

#import "ZCCFixedSegmentVC.h"
#import "ZCCSegmentView.h"

@interface ZCCFixedSegmentVC ()<ZCCSegmentViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) ZCCSegmentView *segmentView;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation ZCCFixedSegmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSubViews];
}

- (void)loadSubViews {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // ————————————切换栏—————————————
    ZCCSegmentView *segmentView = [[ZCCSegmentView alloc] initWithSegmentsArray:@[@"菜单栏1", @"测试测试测试", @"菜单栏333"] seletedIcon:nil margin:kWidth(10) normalFontSize:kWidth(30) selectFontSize:kWidth(34)];
    CGSize segmentSize = [segmentView getSegmentViewSize];
    segmentView.frame = CGRectMake(20, 100, segmentSize.width, segmentSize.height);
    segmentView.sliderType = ZCCSegmentBottomSliderFixed; //固定宽
    [self.view addSubview:segmentView];
    _segmentView = segmentView;
    segmentView.delegate = self;
    
    // ————————————下面是滚动页面————————————
    CGFloat scrollViewW = kScreenW;
    CGFloat scrollViewH = kScreenH - CGRectGetMaxY(segmentView.frame);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentView.frame), kScreenW, scrollViewH)];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(scrollView.width * 3, scrollView.height);
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    UITableView *tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, scrollViewH)];
    tableView1.backgroundColor = ZCCRandomColor;
    UITableView *tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(scrollViewW, 0, kScreenW, scrollViewH)];
    tableView2.backgroundColor = ZCCRandomColor;
    UITableView *tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(scrollViewW * 2, 0, kScreenW, scrollViewH)];
    tableView3.backgroundColor = ZCCRandomColor;
    
    [scrollView addSubview:tableView1];
    [scrollView addSubview:tableView2];
    [scrollView addSubview:tableView3];
}

// 第二步接受点击代理
- (void)segmentLabelTapedIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.width, self.scrollView.contentOffset.y) animated:YES];
}

// 第三步关联滚动动态offsetx
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segmentView updateSliderBarWithScrollViewOffserX:scrollView.contentOffset.x scrollViewWidth:scrollView.width];
}

@end
