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
    UILabel *label = [cell viewWithTag:100] ;
    CheckListItem *itemData = _items[indexPath.row] ;
    
    label.text = itemData.text ;
    cell.accessoryType = itemData.checked?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
    
    CheckListItem *itemData = _items[indexPath.row] ;
    itemData.checked = !itemData.checked ;
    
    if(itemData.checked){
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone ;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
}

@end
