//
//  ListDetailViewController.h
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ListDetailViewController ;
@class CheckList ;

@protocol ListDetailViewControllerDelegate <NSObject>

-(void)listDetailViewControllerDidCancel:(ListDetailViewController*)controller ;
-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingCheckList:(CheckList*)item ;
-(void)listDetailViewController:(ListDetailViewController*)controller didFinishEditingCheckList:(CheckList*)item ;

@end

@interface ListDetailViewController : UITableViewController

@property(weak ,nonatomic)id<ListDetailViewControllerDelegate> delegate ;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@property(strong ,nonatomic)CheckList* checkListToEdit ;

@end
