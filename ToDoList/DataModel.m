//
//  DataModel.m
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel


-(id)init{
    if(self = [super init]){
        [self loadCheckLists] ;
    }
    return self ;
}

#pragma mark - save and load DATA

-(void)saveCheckLists{
    NSMutableData* data = [[NSMutableData alloc]init] ;
    
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data] ;
    
    [archiver encodeObject:self.lists forKey:@"CheckLists"] ;
    [archiver finishEncoding] ;
    [data writeToFile:[self dataFilePath] atomically:YES] ;
}

-(void)loadCheckLists{
    NSString * path = [self dataFilePath] ;
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        NSData* data = [[NSData alloc]initWithContentsOfFile:path] ;
        NSKeyedUnarchiver* unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data] ;
        self.lists = [unArchiver decodeObjectForKey:@"CheckLists"] ;
        [unArchiver finishDecoding] ;
    }else{
        self.lists = [[NSMutableArray alloc]initWithCapacity:20] ;
    }
}

-(NSString*)documentDir{
    ///Users/pengfu/Library/Developer/CoreSimulator/Devices/8D9971F7-1BB7-4487-94F8-79308A112AE9/data/Containers/Data/Application/E384CF31-DF97-4A31-8112-15EB81B0A13F/Documents
    ///Users/pengfu/Library/Developer/CoreSimulator/Devices/8D9971F7-1BB7-4487-94F8-79308A112AE9/data/Containers/Data/Application/E384CF31-DF97-4A31-8112-15EB81B0A13F/Documents/CheckLists.plist
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) ;
    NSString* documentDir = [paths firstObject] ;
    return documentDir ;
}

-(NSString*)dataFilePath{
    return [[self documentDir]stringByAppendingPathComponent:@"CheckLists.plist"] ;
}



@end
