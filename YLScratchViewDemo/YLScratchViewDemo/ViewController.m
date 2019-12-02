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
@property(nonatomic, strong) YLScratchView *scratchCard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建刮刮卡组件
    self.scratchCard = [[YLScratchView alloc] initWithFrame:CGRectMake(20, 120, self.view.frame.size.width - 40, 126) backImage:[UIImage imageNamed:@"result_image"] mask:[UIImage imageNamed:@"mask"] scratchWidth:30 scratchType:kCGLineCapSquare];
    self.scratchCard.delegate = self;
    [self.view addSubview:self.scratchCard];
    
}

- (void)scratchBegan:(CGPoint)point {
    NSLog(@"开始刮奖 %f,%f",point.x,point.y);
}

- (void)scratchMoved:(CGFloat)progress {
    NSLog(@"刮奖百分比：%f",progress);
    if (progress>=0.35) {//百分之15
        [self.scratchCard.scratchMask removeFromSuperview];
    }
}

- (void)scratchEnded:(CGPoint)point {
    NSLog(@"刮奖结束%f,%f",point.x,point.y);

    
}
@end
