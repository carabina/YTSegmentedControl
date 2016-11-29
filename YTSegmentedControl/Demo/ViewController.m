//
//  ViewController.m
//  Demo
//
//  Created by songyutao on 2016/11/29.
//  Copyright © 2016年 Creditease. All rights reserved.
//

#import "ViewController.h"
#import "YTSegmentedControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YTSegmentedItem *item = [[YTSegmentedItem alloc] initWithTitle:@"zero" image:[UIImage imageNamed:@"email"] selectImage:[UIImage imageNamed:@"email"]];
    YTSegmentedItem *item2 = [[YTSegmentedItem alloc] initWithTitle:@"one" image:[UIImage imageNamed:@"feedback"] selectImage:[UIImage imageNamed:@"feedback"]];
    YTSegmentedItem *item3 = [[YTSegmentedItem alloc] initWithTitle:@"two" image:[UIImage imageNamed:@"email"] selectImage:[UIImage imageNamed:@"email"]];
    YTSegmentedItem *item4 = [[YTSegmentedItem alloc] initWithTitle:@"three" image:[UIImage imageNamed:@"feedback"] selectImage:[UIImage imageNamed:@"feedback"]];

    YTSegmentedControl *segmentedControl = [[YTSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:item, item2, item3, item4, nil]];
    segmentedControl.frame = CGRectMake(10, 40, 200, 50);
    [segmentedControl addTarget:self action:@selector(segmentedControlSelected:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentedControlSelected:(YTSegmentedControl *)segmentedControl
{
    NSLog(@"%ld", segmentedControl.selectedIndex);
}

@end
