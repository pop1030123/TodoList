//
//  AddItemViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 02/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "AddItemViewController.h"
#import "CheckListItem.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

-(BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string{
    NSString* newText = [textField.text stringByReplacingCharactersInRange:range withString:string] ;
    
    if([newText length] > 0){
        self.doneBarButton.enabled = YES ;
    }else{
        self.doneBarButton.enabled = NO ;
    }
    
    return YES ;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    [self.textField becomeFirstResponder] ;
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

-(NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return nil ;
}

- (IBAction)cancel:(id)sender {
    [self.delegate addItemViewControllerDidCancel:self] ;
}

- (IBAction)done:(id)sender {
    NSLog(@"the input is %@" ,[self.textField text]) ;
    
    CheckListItem* newItem = [[CheckListItem alloc]init] ;
    newItem.text = self.textField.text ;
    newItem.checked = NO ;
    
    [self.delegate addItemViewController:self didFinishAddingItem:newItem] ;
}
@end
