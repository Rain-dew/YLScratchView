//
//  YLTestCell.m
//  YLScratchViewDemo
//
//  Created by 张雨露 on 2021/9/9.
//  Copyright © 2021 Raindew. All rights reserved.
//

#import "YLTestCell.h"

@implementation YLTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.scratchView = [[YLScratchView alloc] initWithFrame:CGRectMake(20, 20, 260, 126) backImage:[UIImage imageNamed:@"result_image"] mask:[UIImage imageNamed:@"mask"] scratchWidth:30 scratchType:kCGLineCapSquare];
        self.scratchView.delegate = self;
        [self.contentView addSubview:self.scratchView];
        self.contentView.backgroundColor = [UIColor systemOrangeColor];
    }
    return self;
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

//重置刮奖参考如下代码
- (void)resetScratch {
    if (self.scratchView) {
        [self.scratchView removeFromSuperview];
    }
    self.scratchView = [[YLScratchView alloc] initWithFrame:CGRectMake(20, 20, 260, 126) backImage:[UIImage imageNamed:@"result_image"] mask:[UIImage imageNamed:@"mask"] scratchWidth:30 scratchType:kCGLineCapSquare];
    self.scratchView.delegate = self;
    [self.contentView addSubview:self.scratchView];
}

@end
