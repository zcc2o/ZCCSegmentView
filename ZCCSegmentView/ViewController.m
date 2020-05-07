//
//  ViewController.m
//  ZCCSegmentView
//
//  Created by Laibu tech_2 on 2020/4/28.
//  Copyright © 2020 Laibu tech_2. All rights reserved.
//

#import "ViewController.h"
#import "ZCCFixedSegmentVC.h"
#import "ZCCUnFixedSegmentVC.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self);
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (IBAction)fixedClicked:(id)sender {
    ZCCFixedSegmentVC *fixedSegmentVC = [[ZCCFixedSegmentVC alloc] init];
    [self.navigationController pushViewController:fixedSegmentVC animated:YES];
}

- (IBAction)unfixedClicked:(id)sender {
    ZCCUnFixedSegmentVC *unFixedSegmentVC = [[ZCCUnFixedSegmentVC alloc] init];
    [self.navigationController pushViewController:unFixedSegmentVC animated:YES];
}

@end
