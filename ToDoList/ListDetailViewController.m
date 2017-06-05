//
//  ListDetailViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "ListDetailViewController.h"
#import "CheckList.h"
#import "IconPickerViewController.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

NSString* _iconName ;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.checkListToEdit != nil){
        self.title = @"Edit CheckList" ;
        self.textField.text = self.checkListToEdit.name ;
        self.doneBarButton.enabled = YES ;
        self.iconImageView.image = [UIImage imageNamed:self.checkListToEdit.iconName] ;
    }else{
    
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
        self.checkListToEdit.iconName = _iconName ;
        [self.delegate listDetailViewController:self didFinishEditingCheckList:self.checkListToEdit] ;
    }else{
        CheckList* newCheckList = [[CheckList alloc]init] ;
        newCheckList.name = self.textField.text ;
        newCheckList.iconName = _iconName ;
        [self.delegate listDetailViewController:self didFinishAddingCheckList:newCheckList] ;
    }
}

-(BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string{
    NSString* newText = [textField.text stringByReplacingCharactersInRange:range withString:string] ;
    self.doneBarButton.enabled = [newText length] > 0 ;
    return YES ;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"PickIcon"]){
        IconPickerViewController* controller = segue.destinationViewController ;
        controller.delegate = self ;
    }
}

-(void)iconPicker:(IconPickerViewController *)controller didPickIcon:(NSString *)iconName{
    self.iconImageView.image = [UIImage imageNamed:iconName] ;
    _iconName = iconName ;
    [self.navigationController popViewControllerAnimated:YES] ;
}

#pragma mark - Table view data source
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return indexPath ;
    }else{
        return nil ;
    }
}

@end
