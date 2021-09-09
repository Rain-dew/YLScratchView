//
//  YLScratchTableView.m
//  YLScratchViewDemo
//
//  Created by 张雨露 on 2021/9/9.
//  Copyright © 2021 Raindew. All rights reserved.
//

#import "YLScratchTableView.h"

@implementation YLScratchTableView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"YLScratchMaskView"]) {
        return NO;      //关闭手势
    }
    return YES;
}

@end
