//
//  ViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 31/05/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "ViewController.h"
#import "CheckListItem.h"

@interface ViewController ()

@end

@implementation ViewController


NSMutableArray *_items ;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _items = [NSMutableArray arrayWithCapacity:20] ;
    
    CheckListItem *item ;
    
    item = [[CheckListItem alloc]init] ;
    item.text = @"吃饭" ;
    item.checked = NO ;
    [_items addObject:item] ;

    item = [[CheckListItem alloc]init] ;
    item.text = @"睡觉" ;
    item.checked = YES ;
    [_items addObject:item] ;
    
    item = [[CheckListItem alloc]init] ;
    item.text = @"打豆豆" ;
    item.checked = NO ;
    [_items addObject:item] ;
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count] ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"checkListItem"] ;
    CheckListItem *itemData = _items[indexPath.row] ;
    
    [self configTextForCell:cell withCheckListItem:itemData] ;
    [self configCheckmarkForCell:cell withCheckListItem:itemData] ;

    return cell ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
    
    CheckListItem *itemData = _items[indexPath.row] ;
    [itemData toggleChecked] ;
    
    [self configCheckmarkForCell:cell withCheckListItem:itemData] ;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
}

-(void)configCheckmarkForCell:(UITableViewCell*)cell withCheckListItem:(CheckListItem*)item{
    UILabel* label = [cell viewWithTag:101] ;
    
    if(item.checked){
        label.text = @"√" ;
    }else{
        label.text = @"" ;
    }
}

-(void)configTextForCell:(UITableViewCell*)cell withCheckListItem:(CheckListItem*)item{
    UILabel *label = [cell viewWithTag:100] ;
    label.text = item.text ;
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    [_items removeObjectAtIndex:indexPath.row] ;
    
    NSArray* indexPaths = @[indexPath] ;
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic] ;
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(CheckListItem *)item{
    
    NSInteger newRowIndex = [_items count] ;
    [_items addObject:item] ;
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0] ;
    
    NSArray* indexPaths = @[indexPath] ;
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic] ;
    
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(CheckListItem *)item{
    NSInteger index = [_items indexOfObject:item] ;
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
        addItemController.itemToEdit = _items[indexPath.row] ;
    }
}

@end
