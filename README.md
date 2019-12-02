# YLScratchView
刮奖.....嗯~就是你想要的那种
```Object-C

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
    if (progress>=0.25) {//百分之25
        [self.scratchCard.scratchMask removeFromSuperview];
    }
}

- (void)scratchEnded:(CGPoint)point {
    NSLog(@"刮奖结束%f,%f",point.x,point.y);

    
}
 ```
###效果

![image](https://github.com/Rain-dew/YLScratchView/blob/master/YLScratchViewDemo/2019-12-02%2020.10.12.gif)
