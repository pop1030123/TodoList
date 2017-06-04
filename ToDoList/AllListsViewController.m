//
//  AllListsViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "AllListsViewController.h"
#import "CheckList.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController

NSMutableArray* _lists ;


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        _lists = [[NSMutableArray alloc]initWithCapacity:20] ;
        
        CheckList* checkList ;
        
        checkList = [[CheckList alloc]init] ;
        checkList.name = @"Work" ;
        [_lists addObject:checkList] ;
        
        checkList = [[CheckList alloc]init] ;
        checkList.name = @"Study" ;
        [_lists addObject:checkList] ;
        
        checkList = [[CheckList alloc]init] ;
        checkList.name = @"Family" ;
        [_lists addObject:checkList] ;
        
    }
    return self ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [_lists count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"cell" ;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    CheckList* checkList = _lists[indexPath.row] ;
    
    cell.textLabel.text = checkList.name ;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowCheckList" sender:nil] ;
}



@end
