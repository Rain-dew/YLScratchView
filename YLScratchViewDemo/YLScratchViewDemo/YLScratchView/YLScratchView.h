//
//  YLScratchView.h
//
//  Created by Raindew on 2019/12/2.
//  Copyright © 2019 WhatsXie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YLScratchView;
@protocol YLScratchViewDelegate <NSObject>
//开始刮奖
- (void)scratchView:(YLScratchView *)scratchView beganPoint:(CGPoint)point;
//刮奖的比例
- (void)scratchView:(YLScratchView *)scratchView movedProgress:(CGFloat)progress;
//结束刮奖
- (void)scratchView:(YLScratchView *)scratchView endedPoint:(CGPoint)point;

@end

@interface YLScratchMaskView : UIImageView
@property(nonatomic, strong) YLScratchView *scratchView;

@end


@interface YLScratchView : UIView

/// 初始化刮奖View
/// @param frame frame
/// @param image 刮奖结果的图片
/// @param maskImage 遮罩刮奖结果的图
/// @param scratchWidth 每次刮出的宽度
/// @param scratchType 刮奖线条的枚举
- (instancetype)initWithFrame:(CGRect)frame backImage:(UIImage *)image mask:(UIImage *)maskImage scratchWidth:(CGFloat)scratchWidth scratchType:(CGLineCap)scratchType;
//涂层
@property (nonatomic, strong) YLScratchMaskView *scratchMask;
//底层券面图片
@property (nonatomic, strong) UIImageView *backImageView;
//刮刮卡代理对象
@property (nonatomic, weak, nullable) id<YLScratchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
