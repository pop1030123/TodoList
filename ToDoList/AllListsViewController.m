//
//  AllListsViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "AllListsViewController.h"
#import "CheckList.h"
#import "CheckListViewController.h"

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
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton ;
    
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CheckList* checkList = _lists[indexPath.row] ;
    
    [self performSegueWithIdentifier:@"ShowCheckList" sender:checkList] ;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_lists removeObjectAtIndex:indexPath.row] ;
    
//    [self saveCheckListItems] ;
    
    NSArray* indexPaths = @[indexPath] ;
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic] ;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UINavigationController* navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"] ;
    
    ListDetailViewController* listDetailViewController = (ListDetailViewController*) navigationController.topViewController ;
    listDetailViewController.delegate = self ;
    listDetailViewController.checkListToEdit = _lists[indexPath.row] ;
    
    [self presentViewController:navigationController animated:YES completion:nil] ;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowCheckList"]){
        CheckListViewController* viewController = segue.destinationViewController ;
        viewController.checkList = sender ;
    }else if([segue.identifier isEqualToString:@"AddCheckList"]){
        UINavigationController* navController = segue.destinationViewController ;
        ListDetailViewController* listViewController = (ListDetailViewController*)navController.topViewController ;
        listViewController.delegate = self ;
        listViewController.checkListToEdit = nil ;
    }
}


-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingCheckList:(CheckList *)item{
    
    NSInteger newRowIndex = [_lists count] ;
    [_lists addObject:item] ;
    
//    [self saveCheckListItems] ;
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0] ;
    
    NSArray* indexPaths = @[indexPath] ;
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic] ;
    
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingCheckList:(CheckList *)item{
    NSInteger index = [_lists indexOfObject:item] ;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0] ;
    
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.textLabel.text = item.name ;
//    [self saveCheckListItems] ;
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

-(void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

@end
