//
//  AddItemViewController.h
//  ToDoList
//
//  Created by 鹏 付 on 02/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AddItemViewController ;
@class CheckListItem ;

@protocol AddItemViewControllerDelegate <NSObject>

-(void)addItemViewControllerDidCancel:(AddItemViewController*)controller ;
-(void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(CheckListItem*)item ;
-(void)addItemViewController:(AddItemViewController*)controller didFinishEditingItem:(CheckListItem*)item ;

@end

@interface AddItemViewController : UITableViewController<UITextFieldDelegate>

@property(weak ,nonatomic)id<AddItemViewControllerDelegate> delegate ;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@property(strong ,nonatomic)CheckListItem* itemToEdit ;

@end
