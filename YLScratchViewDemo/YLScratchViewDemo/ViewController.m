//
//  ViewController.m
//  YLScratchViewDemo
//
//  Created by 张雨露 on 2019/12/2.
//  Copyright © 2019 Raindew. All rights reserved.
//

#import "ViewController.h"
//#import "YLScratchView.h"
#import "YLScratchTableView.h"
#import "YLTestCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) YLScratchTableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建刮刮卡组件
    
    self.tableView = [[YLScratchTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 166;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[YLTestCell class] forCellReuseIdentifier:@"YLTestCell"];
    

    
}


- (nonnull UITableViewCell *)tableView:(nonnull YLScratchTableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row==3) {
        YLTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YLTestCell" forIndexPath:indexPath];
        return cell;
    }else {
        UITableViewCell *cell = [UITableViewCell new];
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.text = @"测试行";
        return cell;
    }

}

- (NSInteger)tableView:(nonnull YLScratchTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

@end
