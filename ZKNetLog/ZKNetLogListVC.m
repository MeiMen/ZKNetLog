//
//  ZKNetLogListVC.m
//
//  Created by ZK-2 on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZKNetLogListVC.h"
#import "ZKNetLogRecorder.h"
#import "ZKNetLogCell.h"
#import "ZKNetLogHeader.h"
@interface ZKNetLogListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) NSArray *dataSource;
@property(strong, nonatomic) UITableView *tableView;
@end

@implementation ZKNetLogListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"ZKNetLogCell" bundle:nil] forCellReuseIdentifier:@"ZKNetLogCell"];
    [self.tableView registerClass:[ZKNetLogCell class] forCellReuseIdentifier:@"ZKNetLogCell"];
    self.tableView.estimatedRowHeight = 300;
    self.dataSource = [[ZKNetLogRecorder sharedRecorder] fetchLogs];
    [self.tableView reloadData];
  
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKNetLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZKNetLogCell" forIndexPath:indexPath];
    NSDictionary *dict = self.dataSource[indexPath.row];
    
    cell.logLabel.text = dict[@"content"];
    cell.title.text = dict[@"title"];
  
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
