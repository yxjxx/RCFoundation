//
//  RCViewController.m
//  RCFoundation
//
//  Created by rico on 06/18/2018.
//  Copyright (c) 2018 rico. All rights reserved.
//

#import "RCViewController.h"
#import "RCCommonConst.h"

@interface RCViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSString *> *vcTitles;

@end

@implementation RCViewController

- (instancetype) init {
    if (self = [super init]) {
        self.vcTitles = [NSMutableArray arrayWithObjects:
                         @"TableView",
                         @"CollectionView",
                         nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.backgroundView = nil;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, RCC_IPHONE_STATUSBAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - RCC_IPHONE_STATUSBAR_HEIGHT);
    //    self.tableView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 44*self.vcTitles.count);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.vcTitles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.vcTitles.count) return;
    NSString *vcTitle = self.vcTitles[indexPath.row];
    UIViewController *vc = [NSClassFromString(vcTitle) new];
    vc.title = vcTitle;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}


@end
