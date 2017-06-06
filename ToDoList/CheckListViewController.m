//
//  CheckListViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 31/05/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "CheckListViewController.h"
#import "CheckListItem.h"
#import "CheckList.h"

@interface CheckListViewController ()

@end

@implementation CheckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = self.checkList.name ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configCheckmarkForCell:(UITableViewCell*)cell withCheckListItem:(CheckListItem*)item{
    UILabel* label = [cell viewWithTag:101] ;
    
    if(item.checked){
        label.text = @"√" ;
    }else{
        label.text = @"" ;
    }
    label.textColor = self.view.tintColor ;
}

-(void)configTextForCell:(UITableViewCell*)cell withCheckListItem:(CheckListItem*)item{
    UILabel *label = [cell viewWithTag:100] ;
//    label.text = item.text ;
    label.text = [NSString stringWithFormat:@"%ld ,%@", item.itemId,item.text] ;
}


#pragma mark - tableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.checkList.items count] ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"checkListItem"] ;
    CheckListItem *itemData = self.checkList.items[indexPath.row] ;
    
    [self configTextForCell:cell withCheckListItem:itemData] ;
    [self configCheckmarkForCell:cell withCheckListItem:itemData] ;

    return cell ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
    
    CheckListItem *itemData = self.checkList.items[indexPath.row] ;
    [itemData toggleChecked] ;
    
    [self configCheckmarkForCell:cell withCheckListItem:itemData] ;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [self.checkList.items removeObjectAtIndex:indexPath.row] ;
    
    NSArray* indexPaths = @[indexPath] ;
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic] ;
}



#pragma mark - itemDetailViewController delegate

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(CheckListItem *)item{
    
    NSInteger newRowIndex = [self.checkList.items count] ;
    [self.checkList.items addObject:item] ;
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0] ;
    
    NSArray* indexPaths = @[indexPath] ;
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic] ;
    
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(CheckListItem *)item{
    NSInteger index = [self.checkList.items indexOfObject:item] ;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0] ;
    
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    [self configTextForCell:cell withCheckListItem:item] ;
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"AddItem"]){
        UINavigationController* navigationController = segue.destinationViewController ;
        ItemDetailViewController* addItemController = (ItemDetailViewController*) navigationController.topViewController ;
        addItemController.delegate = self ;
    }else if([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController* navigationController = segue.destinationViewController ;
        ItemDetailViewController* addItemController = (ItemDetailViewController*) navigationController.topViewController ;
        
        addItemController.delegate = self ;
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender] ;
        addItemController.itemToEdit = self.checkList.items[indexPath.row] ;
    }
}

@end
