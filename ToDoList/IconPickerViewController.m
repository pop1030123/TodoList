//
//  IconPickerViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 05/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController

NSArray* iconArray ;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    iconArray = @[
                  @"No Icon",
                  @"Appointments" ,
                  @"Birthdays" ,
                  @"Chores",
                  @"Drinks",
                  @"Folder",
                  @"Groceries",
                  @"Inbox",
                  @"Photos",
                  @"Trips"] ;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [iconArray count] ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate iconPicker:self didPickIcon:iconArray[indexPath.row]] ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"IconCell"] ;
    cell.textLabel.text = iconArray[indexPath.row] ;
    cell.imageView.image = [UIImage imageNamed:iconArray[indexPath.row]] ;
    return cell ;
}


@end
