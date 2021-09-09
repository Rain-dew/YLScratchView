//
//  YLTestCell.h
//  YLScratchViewDemo
//
//  Created by 张雨露 on 2021/9/9.
//  Copyright © 2021 Raindew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLScratchView.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLTestCell : UITableViewCell <YLScratchViewDelegate>
@property(nonatomic, strong) YLScratchView *scratchView;
- (void)resetScratch;
@end

NS_ASSUME_NONNULL_END
