//
//  AdbHelper.m
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import "AdbHelper.h"

@implementation ADBHelper


- (NSString *) runTask: (NSArray*)args{
    
    NSString *resPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @""];
    NSString *finalPath = [NSString stringWithFormat:@"%@/%@", resPath, @"runner.sh"];
    
    NSMutableArray *final_withArg;
    final_withArg = [NSMutableArray arrayWithObjects: finalPath, nil];
    [final_withArg addObjectsFromArray:args];
    
    NSTask *task = [NSTask new];
    task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [task setCurrentDirectoryPath:resPath];
    [task setArguments:final_withArg];
    
    //NSLog([final_withArg componentsJoinedByString:@""]);
    
    NSPipe *outputPipe = [NSPipe pipe];
    [task setStandardInput:[NSPipe pipe]];
    [task setStandardOutput:outputPipe];
    
    [task launch];
    [task waitUntilExit]; // Alternatively, make it asynchronous.
    
    NSData *outputData = [[outputPipe fileHandleForReading] readDataToEndOfFile];
    NSString *outputString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
    
    return outputString;
}

- (NSString *)getFileList: (NSString*)path{
    NSArray* args = [NSArray arrayWithObjects: @"1", path, nil];
    
    return [self runTask:args];
}

- (NSString *)getAdbVersion{
    NSArray* args = [NSArray arrayWithObjects: @"0", nil];
    return [self runTask:args];
}

@end



