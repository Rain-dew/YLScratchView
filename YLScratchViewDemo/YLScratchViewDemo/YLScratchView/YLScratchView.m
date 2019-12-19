//
//  YLScratchView.m
//
//  Created by Raindew on 2019/12/2.
//  Copyright © 2019 WhatsXie. All rights reserved.
//

#import "YLScratchView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLScratchMaskView ()

//代理对象
@property (nonatomic, weak, nullable) id<YLScratchViewDelegate> delegate;
//线条形状
@property (nonatomic, assign) CGLineCap lineType;
//线条粗细
@property (nonatomic, assign) CGFloat lineWidth;
//保存上一次停留的位置
@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation YLScratchMaskView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *__nullable)event {
    //多点触摸只考虑第一点
    if (![touches anyObject]) return;
    //保存当前点坐标
    self.lastPoint = [[touches anyObject] locationInView:self];
    //调用相应的代理方法
    [self.delegate scratchView:self.scratchView beganPoint:self.lastPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *__nullable)event {
    //多点触摸只考虑第一点
    if (![touches anyObject]) return;
    //获取最新触摸点坐标
    CGPoint newPoint = [[touches anyObject] locationInView:self];
    //清除两点间的涂层
    [self eraseMask:self.lastPoint to:newPoint];
    //保存最新触摸点坐标，供下次使用
    self.lastPoint = newPoint;
    //计算刮开面积的百分比
    CGFloat progress = [self getAlphaPixelPercent:self.image];
    //调用相应的代理方法
    [self.delegate scratchView:self.scratchView movedProgress:progress];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *__nullable)event {
    //多点触摸只考虑第一点
    if (![touches anyObject]) return;
    //调用相应的代理方法
    [self.delegate scratchView:self.scratchView endedPoint:self.lastPoint];
}
//清除两点间的涂层
- (void)eraseMask:(CGPoint)fromPoint to:(CGPoint)toPoint {
    //根据size大小创建一个基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, [UIScreen mainScreen].scale);
    
    //先将图片绘制到上下文中
    [self.image drawInRect:self.bounds];
    
    //再绘制线条
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, fromPoint.x, fromPoint.y);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, toPoint.x, toPoint.y);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(ctx, YES);
    CGContextSetLineCap(ctx, self.lineType);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextSetBlendMode(ctx, kCGBlendModeClear); //混合模式设为清除
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
    //将二者混合后的图片显示出来
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束图形上下文
    UIGraphicsEndImageContext();
}
//获取透明像素占总像素的百分比
- (CGFloat)getAlphaPixelPercent:(UIImage *)img {
    
    //计算像素总个数
    NSInteger width = img.size.width;
    NSInteger height = img.size.height;
    NSInteger bitmapByteCount = width * height;
    unsigned char *pixelData = malloc(bitmapByteCount * 4);


    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(pixelData, width, height, 8, width, colorSpace, kCGImageAlphaOnly);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextClearRect(context, rect);
    CGContextDrawImage(context, rect, img.CGImage);
    //计算透明像素个数
    NSInteger alphaPixelCount = 0;
    for (NSInteger y=0;y < height;y ++) {
        for (NSInteger x=0;x < width;x ++) {
            if (pixelData[y * width + x] == 0) {
                alphaPixelCount += 1;
            }
        }
    }
    
    free(pixelData);
    return ((CGFloat)alphaPixelCount) / ((CGFloat)bitmapByteCount);
    
}



@end

@interface YLScratchView ()
@property(nonatomic, assign) CGRect childFrame;
@property(nonatomic, strong) UIImage *maskImage;
@property(nonatomic, assign) CGFloat scratchWidth;
@property(nonatomic, assign) CGLineCap scratchType;
@property(nonatomic, strong) UIImage *backImage;
@end

@implementation YLScratchView
- (YLScratchMaskView *)scratchMask {
    if (!_scratchMask) {
        _scratchMask = [[YLScratchMaskView alloc] initWithFrame:self.childFrame];
        _scratchMask.userInteractionEnabled = YES;
        _scratchMask.scratchView = self;
        _scratchMask.image = self.maskImage;
        _scratchMask.lineWidth = self.scratchWidth;
        _scratchMask.lineType = self.scratchType;
    }
    return _scratchMask;
}
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:self.childFrame];
        _backImageView.image = self.backImage;
    }
    return _backImageView;
}
- (void)setDelegate:(id __nullable)delegate {
    _delegate = delegate;
    _scratchMask.delegate = delegate;
}

- (instancetype)initWithFrame:(CGRect)frame backImage:(UIImage *)image mask:(UIImage *)maskImage scratchWidth:(CGFloat)scratchWidth scratchType:(CGLineCap)scratchType {
    if (self = [super initWithFrame:frame]) {
        CGRect childFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.childFrame = childFrame;
        self.maskImage = maskImage;
        self.scratchWidth = scratchWidth;
        self.scratchType = scratchType;
        self.backImage = image;
        
        //添加底层券面
        [self addSubview:self.backImageView];
        //添加涂层
        [self addSubview:self.scratchMask];
        
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
