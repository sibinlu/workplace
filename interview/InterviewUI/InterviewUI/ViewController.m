//
//  ViewController.m
//  InterviewUI
//
//  Created by Sibin Lu on 2017/4/3.
//  Copyright © 2017年 Sibin Lu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UICollectionView* _collectionView;
    UITableView* _tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:
                  CGRectMake(0,
                             [UIApplication sharedApplication].statusBarFrame.size.height,
                             self.view.bounds.size.width,
                             self.view.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)
                                              style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    static NSString* key = @"key";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:key];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:key];
    }
    
    if(indexPath.row==1){
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
