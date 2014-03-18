//
//  TableViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.model = [[NSMutableArray alloc ] init ];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:@"navigation_Back.png" backgroundImage:nil target:self action:@selector(back)];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitRequestWithParams:(NSDictionary *)params withUrl:(NSString *)url{
    [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:url withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        NSLog(@"request start");
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        [self setDataDic:request.handleredResult toManager:nil];
        NSLog(@"request finish");
        [self responseSuccessWithResponse:request];
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
        NSLog(@"request cancel");
        [self responseFailWithResponse:request];
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
        [self responseCancelWithResponse:request];
        NSLog(@"request fail");
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"加载失败"];
        
    }];
}

#pragma mark - Response Success
- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    
}

#pragma mark - Response Fail
- (void)responseFailWithResponse:(ITTBaseDataRequest *)request{
    
}

#pragma mark - Response Cancel
- (void)responseCancelWithResponse:(ITTBaseDataRequest *)request{
    
}

- (void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManager
{
    /**
     *  返回数据
     */
    NSLog(@"resultDic  %@", resultDic);
    if (resultDic[@"result"] && [resultDic[@"result"] isKindOfClass:[NSArray class]]) {
        [self.model addObjectsFromArray:resultDic[@"result"]];
    }else{
        self.model = resultDic[@"result"];
    }
    [self reloadNewData];
}

// 数据接收成功后 用新数据刷新view
- (void)reloadNewData{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
