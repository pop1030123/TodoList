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
#import "CheckListItem.h"
#import "DataModel.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController

#pragma mark - life circle callBack

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated] ;
    self.navigationController.delegate = self ;
    NSInteger index = [self.dataModel indexOfCheckList] ;
    NSLog(@"viewDidAppear:index of checkList:%ld" ,(long)index) ;
    if(index >=0 && index < [self.dataModel.lists count]){
        CheckList* checkList = _dataModel.lists[index] ;
        [self performSegueWithIdentifier:@"ShowCheckList" sender:checkList] ;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    [self.tableView reloadData] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navigationController:(UINavigationController*)navigationController willShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated{
    if(self == viewController){
        [_dataModel setIndexOfCheckList:-1] ;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataModel.lists count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"cell" ;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] ;
    }
    CheckList* checkList = self.dataModel.lists[indexPath.row] ;
    
    cell.textLabel.text = checkList.name ;
    int unDoneCount = [checkList countUnDoneItem] ;
    if(unDoneCount == 0){
        if([checkList.items count] == 0){
            cell.detailTextLabel.text = @"No Items" ;
        }else{
            cell.detailTextLabel.text = @"All Done" ;
        }
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d remain.",unDoneCount] ;
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton ;
    
    cell.imageView.image = [UIImage imageNamed:checkList.iconName] ;
    
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_dataModel setIndexOfCheckList:indexPath.row] ;
    
    CheckList* checkList = self.dataModel.lists[indexPath.row] ;
    
    [self performSegueWithIdentifier:@"ShowCheckList" sender:checkList] ;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.dataModel.lists removeObjectAtIndex:indexPath.row] ;
    
    NSArray* indexPaths = @[indexPath] ;
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic] ;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UINavigationController* navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"] ;
    
    ListDetailViewController* listDetailViewController = (ListDetailViewController*) navigationController.topViewController ;
    listDetailViewController.delegate = self ;
    listDetailViewController.checkListToEdit = self.dataModel.lists[indexPath.row] ;
    
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

#pragma mark - delegate

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingCheckList:(CheckList *)item{
    
    [self.dataModel.lists addObject:item] ;
    [self.dataModel sortList] ;
    [self.tableView reloadData] ;
    
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingCheckList:(CheckList *)item{
    [self.dataModel sortList] ;
    [self.tableView reloadData] ;
    
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

-(void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

@end
