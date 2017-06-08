//
//  ItemDetailViewController.m
//  ToDoList
//
//  Created by 鹏 付 on 02/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "CheckListItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

NSDate* _dueDate ;
BOOL _datePickerVisible ;

-(void)dateChanged:(UIDatePicker*)datePicker{
    _dueDate = datePicker.date ;
    [self updateDueDateLabel] ;
}

-(void)showDatePicker{
    _datePickerVisible = YES ;
    NSIndexPath* indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1] ;
    [self.tableView insertRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationAutomatic] ;
}
-(void)hideDatePicker{
    if(_datePickerVisible){
        _datePickerVisible = NO ;
        NSIndexPath* indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1] ;
        NSIndexPath* indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1] ;
        
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPathDateRow] ;
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.0f alpha:0.5f] ;
        
        [self.tableView beginUpdates] ;
        [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone] ;
        [self.tableView deleteRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade] ;
        
        [self.tableView endUpdates] ;
    }
}

-(BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string{
    NSString* newText = [textField.text stringByReplacingCharactersInRange:range withString:string] ;
    
    self.doneBarButton.enabled = [newText length] > 0 ;
    
    return YES ;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    [self.textField becomeFirstResponder] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.itemToEdit != nil){
        self.title = @"Edit Item" ;
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES ;
        self.switchControl.on = self.itemToEdit.shouldRemind ;
        _dueDate = self.itemToEdit.dueDate ;
    }else{
        self.switchControl.on = NO ;
        _dueDate = [NSDate date] ;
    }
    if(!_dueDate){
        _dueDate = [NSDate date] ;
    }
    
    [self updateDueDateLabel] ;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateDueDateLabel{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle] ;
    [formatter setTimeStyle:NSDateFormatterShortStyle] ;
    NSString* dateString =[formatter stringFromDate:_dueDate] ;
    NSLog(@"update date:%@" ,dateString) ;
    self.dueDateLabel.text = dateString ;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self hideDatePicker] ;
}

- (IBAction)cancel:(id)sender {
    [self.delegate itemDetailViewControllerDidCancel:self] ;
}

- (IBAction)done:(id)sender {
    NSLog(@"the input is %@" ,[self.textField text]) ;
    if(self.itemToEdit == nil){
        
        CheckListItem* newItem = [[CheckListItem alloc]init] ;
        newItem.text = self.textField.text ;
        newItem.checked = NO ;
        newItem.dueDate = _dueDate ;
        newItem.shouldRemind = self.switchControl.on ;
        [newItem scheduleNotification] ;
        
        [self.delegate itemDetailViewController:self didFinishAddingItem:newItem] ;
    }else{
        self.itemToEdit.text = self.textField.text ;
        self.itemToEdit.dueDate = _dueDate ;
        self.itemToEdit.shouldRemind = self.switchControl.on ;
        
        [self.itemToEdit scheduleNotification] ;
        
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}

#pragma mark - Table view data source

-(NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.section == 1 && indexPath.row == 1){
        return indexPath ;
    }else{
        return nil ;
    }
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1 && indexPath.row == 2){
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section] ;
        return [super tableView:tableView indentationLevelForRowAtIndexPath:newIndexPath] ;
    }else{
        return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath] ;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 1 && indexPath.row == 2){
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"] ;
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DatePickerCell"] ;
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            
            UIDatePicker* datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 216.0f)] ;
            datePicker.tag = 100 ;
            
            [cell.contentView addSubview:datePicker] ;
            
            [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged] ;
        }
        return cell ;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath] ;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1 && _datePickerVisible){
        return 3 ;
    }else{
        return [super tableView:tableView numberOfRowsInSection:section] ;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1 && indexPath.row == 2){
        return 217.0f ;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath] ;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
    
    [self.textField resignFirstResponder] ;
    
    if(indexPath.section == 1 && indexPath.row == 1){
        if(_datePickerVisible){
            [self hideDatePicker] ;
        }else{
            [self showDatePicker] ;
        }
    }
}

@end
