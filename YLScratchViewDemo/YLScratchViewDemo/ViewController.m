//
//  ViewController.m
//  YLScratchViewDemo
//
//  Created by 张雨露 on 2019/12/2.
//  Copyright © 2019 Raindew. All rights reserved.
//

#import "ViewController.h"
#import "YLScratchView.h"
@interface ViewController ()<YLScratchViewDelegate>
@property(nonatomic, strong) YLScratchView *scratchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建刮刮卡组件
    self.scratchView = [[YLScratchView alloc] initWithFrame:CGRectMake(20, 120, self.view.frame.size.width - 40, 126) backImage:[UIImage imageNamed:@"result_image"] mask:[UIImage imageNamed:@"mask"] scratchWidth:30 scratchType:kCGLineCapSquare];
    self.scratchView.delegate = self;
    [self.view addSubview:self.scratchView];
    
}

- (void)scratchView:(YLScratchView *)scratchView beganPoint:(CGPoint)point {
    NSLog(@"开始刮奖 %f,%f",point.x,point.y);
}

- (void)scratchView:(YLScratchView *)scratchView movedProgress:(CGFloat)progress {
    NSLog(@"刮奖百分比：%f",progress);
    if (progress>=0.25) {//百分之25
        [self.scratchView.scratchMask removeFromSuperview];
    }
}

- (void)scratchView:(YLScratchView *)scratchView endedPoint:(CGPoint)point {
    NSLog(@"刮奖结束%f,%f",point.x,point.y);
    
}
@end
