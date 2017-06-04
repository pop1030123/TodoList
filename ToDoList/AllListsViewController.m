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

@interface AllListsViewController ()

@end

@implementation AllListsViewController

NSMutableArray* _lists ;


-(NSString*)documentDir{
    ///Users/pengfu/Library/Developer/CoreSimulator/Devices/8D9971F7-1BB7-4487-94F8-79308A112AE9/data/Containers/Data/Application/E384CF31-DF97-4A31-8112-15EB81B0A13F/Documents
    ///Users/pengfu/Library/Developer/CoreSimulator/Devices/8D9971F7-1BB7-4487-94F8-79308A112AE9/data/Containers/Data/Application/E384CF31-DF97-4A31-8112-15EB81B0A13F/Documents/CheckLists.plist
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) ;
    NSString* documentDir = [paths firstObject] ;
    return documentDir ;
}

-(NSString*)dataFilePath{
    return [[self documentDir]stringByAppendingPathComponent:@"CheckLists.plist"] ;
}

#pragma mark - save and load DATA

-(void)saveCheckLists{
    NSMutableData* data = [[NSMutableData alloc]init] ;
    
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data] ;
    
    [archiver encodeObject:_lists forKey:@"CheckLists"] ;
    [archiver finishEncoding] ;
    [data writeToFile:[self dataFilePath] atomically:YES] ;
}

-(void)loadCheckLists{
    NSString * path = [self dataFilePath] ;
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        NSData* data = [[NSData alloc]initWithContentsOfFile:path] ;
        NSKeyedUnarchiver* unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data] ;
        _lists = [unArchiver decodeObjectForKey:@"CheckLists"] ;
        [unArchiver finishDecoding] ;
    }else{
        _lists = [[NSMutableArray alloc]initWithCapacity:20] ;
    }
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self loadCheckLists] ;
    }
    return self ;
}

#pragma mark - life circle callBack

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

#pragma mark - delegate

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
