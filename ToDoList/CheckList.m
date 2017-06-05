//
//  CheckList.m
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "CheckList.h"
#import "CheckListItem.h"

@implementation CheckList

-(id)init{
    if(self = [super init]){
        self.items = [[NSMutableArray alloc]initWithCapacity:20] ;
    }
    return self ;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.name = [aDecoder decodeObjectForKey:@"Name"] ;
        self.items = [aDecoder decodeObjectForKey:@"List"] ;
    }
    return self ;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"Name"] ;
    [aCoder encodeObject:self.items forKey:@"List"] ;
}

-(int)countUnDoneItem{
    int count = 0 ;
    for (CheckListItem* item in self.items){
        if(!item.checked){
            count+=1 ;
        }
    }
    return count ;
}


@end
