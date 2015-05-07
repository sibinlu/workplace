//
//  WSIDManagerViewController.m
//  WSID
//
//  Created by sibinlu on 15-5-3.
//  Copyright (c) 2015年 sibinlu. All rights reserved.
//

#import "WSIDManagerViewController.h"
#import "WSIDTaskManager.h"
#import "WSIDTaskViewController.h"
#import "Prefix.h"
#import "WSIDRecitationViewController.h"
#import "WSIDDictionaryViewController.h"
#import "WSIDLearningViewController.h"

@interface WSIDManagerViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView* table;
}
@end

@implementation WSIDManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIButton* b1;
    TopBarButton(b1 , CGRectMake(0, 20, 50, 50) , @"<" , back);
    [self.view addSubview:b1];
    
    UILabel* titleLabel;
    InfoLabel(titleLabel, CGRectMake(160, 20, 150, 50), @"Task List");
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:titleLabel];
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    table.separatorColor = [UIColor blackColor];
    [self.view addSubview:table];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[WSIDTaskManager manager].tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell* cell = [table dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    WSIDTask* task = [[WSIDTaskManager manager].tasks objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"  %@  %d/%d  %d,w%d,t%d",task.taskName,task.countFinished,task.countTotal , task.taskFrequncy, task.finishThisWeek , task.finishToday];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[WSIDTaskManager manager].tasks removeObjectAtIndex:indexPath.row];
        [[WSIDTaskManager manager] save];
        // Delete the row from the data source.
        [table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WSIDTask* task = [[WSIDTaskManager manager].tasks objectAtIndex:indexPath.row];
    WSIDTaskViewController* ctrl = nil;
    if ([task isKindOfClass:[WSIDRecitationTask class]]) {
         ctrl = [[WSIDRecitationViewController alloc] initWithTask:task];
    }
    else if ([task isKindOfClass:[WSIDLearningTask class]]) {
        ctrl = [[WSIDLearningViewController alloc] initWithTask:task];
    }
    else if ([task isKindOfClass:[WSIDDictionaryTask class]]) {
        ctrl = [[WSIDDictionaryViewController alloc] initWithTask:task];
    }
    if (ctrl) {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[WSIDTaskManager manager] checkUpdate];
    [table reloadData];
}
@end
