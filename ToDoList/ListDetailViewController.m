//
//  ListDetailViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "ListDetailViewController.h"
#import "CheckList.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.checkListToEdit != nil){
        self.title = @"Edit CheckList" ;
        self.textField.text = self.checkListToEdit.name ;
        self.doneBarButton.enabled = YES ;
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    [self.textField becomeFirstResponder] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel:(id)sender{
    [self.delegate listDetailViewControllerDidCancel:self] ;
}

-(IBAction)done:(id)sender{
    if(self.checkListToEdit != nil){
        self.checkListToEdit.name = self.textField.text ;
        [self.delegate listDetailViewController:self didFinishEditingCheckList:self.checkListToEdit] ;
    }else{
        CheckList* newCheckList = [[CheckList alloc]init] ;
        newCheckList.name = self.textField.text ;
        [self.delegate listDetailViewController:self didFinishAddingCheckList:newCheckList] ;
    }
}

-(BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string{
    NSString* newText = [textField.text stringByReplacingCharactersInRange:range withString:string] ;
    self.doneBarButton.enabled = [newText length] > 0 ;
    return YES ;
}

#pragma mark - Table view data source
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil ;
}


@end
