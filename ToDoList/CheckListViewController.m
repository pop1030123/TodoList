//
//  CheckListViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 31/05/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "CheckListViewController.h"
#import "CheckListItem.h"

@interface CheckListViewController ()

@end

@implementation CheckListViewController


NSMutableArray *_items ;


-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if(self = [super initWithCoder:aDecoder]){
        [self loadCheckListItems] ;
    }
    return self ;
}

-(void)loadCheckListItems{
    NSString * path = [self dataFilePath] ;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        NSData* data = [[NSData alloc]initWithContentsOfFile:path] ;
        NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data] ;
        
        _items = [unarchiver decodeObjectForKey:@"checkListItems"] ;
        [unarchiver finishDecoding] ;
    }else{
        _items = [NSMutableArray arrayWithCapacity:20] ;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ///Users/pengfu/Library/Developer/CoreSimulator/Devices/8D9971F7-1BB7-4487-94F8-79308A112AE9/data/Containers/Data/Application/E384CF31-DF97-4A31-8112-15EB81B0A13F/Documents
    NSLog(@"doc dir:%@" ,[self documentsDirectory]) ;
    
    ///Users/pengfu/Library/Developer/CoreSimulator/Devices/8D9971F7-1BB7-4487-94F8-79308A112AE9/data/Containers/Data/Application/E384CF31-DF97-4A31-8112-15EB81B0A13F/Documents/CheckLists.plist
    NSLog(@"file path:%@" ,[self dataFilePath]) ;
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSString*)documentsDirectory{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) ;
    
    NSString* documentsDirectory = [paths firstObject] ;
    return documentsDirectory ;
}

-(NSString*)dataFilePath{
    return [[self documentsDirectory]stringByAppendingPathComponent:@"CheckLists.plist"] ;
}

-(void)saveCheckListItems{
    NSMutableData* data = [[NSMutableData alloc]init] ;
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data] ;
    [archiver encodeObject:_items forKey:@"checkListItems"] ;
    [archiver finishEncoding] ;
    [data writeToFile:[self dataFilePath] atomically:YES] ;
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
    
    [self saveCheckListItems] ;
    
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
    
    [self saveCheckListItems] ;
    
    NSArray* indexPaths = @[indexPath] ;
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic] ;
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(CheckListItem *)item{
    
    NSInteger newRowIndex = [_items count] ;
    [_items addObject:item] ;
    
    [self saveCheckListItems] ;
    
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
    [self saveCheckListItems] ;
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
