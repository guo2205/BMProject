//
//  TestRootViewController.m
//  BMProject
//
//  Created by Well on 15/7/2.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import "TestRootViewController.h"

@interface Item : NSObject
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) NSString    *className;
@property (copy, nonatomic) NSString    *viewController;
+ (Item *)itemWithName:(NSString *)name className:(NSString *)className controller:(NSString *)controller;
@end

@implementation Item

+ (Item *)itemWithName:(NSString *)name className:(NSString *)className controller:(NSString *)controller{
    Item *item = [[Item alloc]init];
    item.name = name;
    item.className = className;
    item.viewController = controller;
    
    return item;
}

@end

@interface TestRootViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView        *compTable;
@property (strong, nonatomic) NSMutableArray     *dataSource;
@end

@implementation TestRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Gear";
    self.dataSource = [NSMutableArray array];
    self.compTable = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.compTable.delegate = self;
    self.compTable.dataSource = self;
    [self.view addSubview:self.compTable];
    
    NSArray *array = @[[Item itemWithName:@"K线图" className:@"KlineView" controller:@"BMKlineController"],
                       [Item itemWithName:@"城市列表" className:@"BMCitiesListView" controller:@"BMCityController"],
                       [Item itemWithName:@"日历" className:@"DSLCalendarView" controller:@"BMCalendarController"],
                       [Item itemWithName:@"图片裁剪" className:@"PECropViewController" controller:@"BMCropImageController"],
                       [Item itemWithName:@"广告轮播" className:@"LoopScrollView" controller:@"BMLoopBannerController"],
                       [Item itemWithName:@"二维码扫描" className:@"BMQRCodeController" controller:@"BMQRCodeViewController"],
                       [Item itemWithName:@"蓝牙模版示例" className:@"BMBluetoothController" controller:@"BMBluetoothController"],
                       [Item itemWithName:@"数据库操作示例" className:@"DatabaseController" controller:@"DatabaseController"],
                       [Item itemWithName:@"下拉刷新操作示例" className:@"PullRefreshController" controller:@"PullRefreshController"],
                       [Item itemWithName:@"购物车" className:@"ShoppingCartController" controller:@"ShoppingCartController"],
                       [Item itemWithName:@"手势密码" className:@"CLLockVC" controller:@"GesturePasswordControllerTest"],
                       [Item itemWithName:@"收获地址" className:@"ConsignAddressController" controller:@"ConsignAddressController"]];
    
    for (int i = 0; i < array.count; i ++) {
        Item *item = array[i];
        Class class = NSClassFromString(item.viewController);
        if (class != nil) {
            [self.dataSource addObject:item];
        }
    }
    [self.compTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ReuseCellIdentifier"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseCellIdentifier"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Item *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Item *item = self.dataSource[indexPath.row];
    UIViewController *vc = [[NSClassFromString(item.viewController) alloc]init];
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)backClick:(UIBarButtonItem *)item{
    
}

@end
