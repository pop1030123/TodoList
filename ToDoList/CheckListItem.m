//
//  CheckListItem.m
//  ToDoList
//
//  Created by 鹏 付 on 31/05/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "CheckListItem.h"
#import "DataModel.h"

@implementation CheckListItem


-(instancetype)init{
    self = [super init] ;
    if(self){
        self.itemId = [DataModel nextCheckListItemId] ;
    }
    return self ;
}

-(void)toggleChecked{
    self.checked = !self.checked ;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.text = [aDecoder decodeObjectForKey:@"Text"] ;
        self.checked = [aDecoder decodeBoolForKey:@"Checked"] ;
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"] ;
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"] ;
        self.itemId = [aDecoder decodeIntegerForKey:@"ItemId"] ;
    }
    return self ;
}

-(void)scheduleNotification{
    if(self.shouldRemind
       &&
       [self.dueDate compare:[NSDate date]] != NSOrderedAscending){
        
//        UILocalNotification *localNotification = [[UILocalNotification alloc]init] ;
//        localNotification.fireDate = self.dueDate ;
//        UNMutableNotificationContent *hello=[[UNMutableNotificationContent alloc] init];
    }
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"Text"] ;
    [aCoder encodeBool:self.checked forKey:@"Checked"] ;
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"] ;
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"] ;
    [aCoder encodeInteger:self.itemId forKey:@"ItemId"];
}
@end
