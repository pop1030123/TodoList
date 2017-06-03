//
//  CheckListItem.m
//  ToDoList
//
//  Created by 鹏 付 on 31/05/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "CheckListItem.h"

@implementation CheckListItem

-(void)toggleChecked{
    self.checked = !self.checked ;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.text = [aDecoder decodeObjectForKey:@"Text"] ;
        self.checked = [aDecoder decodeBoolForKey:@"Checked"] ;
    }
    return self ;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"Text"] ;
    [aCoder encodeBool:self.checked forKey:@"Checked"] ;
}
@end
